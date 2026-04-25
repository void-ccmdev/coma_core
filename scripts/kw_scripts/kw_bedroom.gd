extends Node3D

@export var trigger_door : Door
@export var player : PlayerController
@export var post_process : PostProcess
@export var fade_box : FadeBox
@export var next_scene : PackedScene

@export var cs_camera : Camera3D
@export var outside_marker : Marker3D
@export var inside_marker : Marker3D
@export var cutscene_triggered : bool = false
@export var cs_camera_container : Node3D

@export var door_audio : RaytracedAudioPlayer3D
@export var wind_audio : AudioStreamPlayer

func _ready() -> void:
	await get_tree().create_timer(2.25).timeout
	door_audio.play()

func _process(_delta: float) -> void:
	if !trigger_door.closed:
		cutscene()
		door_audio.stop()
		if !wind_audio.playing:
			await get_tree().create_timer(0.15).timeout
			wind_audio.play()

func cutscene() -> void:
	if !cutscene_triggered:
		cs_camera.global_position = inside_marker.global_position
		cs_camera.current = true
		player.hide()
		player.global_position = Vector3(-100,-100,-100)

		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

		await get_tree().create_timer(0.2).timeout

		var ts = get_tree().create_tween()
		ts.tween_property(cs_camera_container, "global_position", outside_marker.global_position, 0.6).set_trans(ts.TRANS_CUBIC)
		ts.set_parallel()
		ts.tween_property(cs_camera_container, "rotation", Vector3(0,0, deg_to_rad(25)), 0.4).set_trans(ts.TRANS_CUBIC)
	else:
		await get_tree().create_timer(0.5).timeout

		cs_camera_container.look_at(trigger_door.global_position, Vector3.UP, false)

		cs_camera.global_rotation.y += deg_to_rad(6)
		cs_camera_container.global_position.y -= 0.5
	
	if abs(cs_camera_container.global_position.y) >= 60:

		set_next_scene()
	

	cutscene_triggered = true

func set_next_scene() -> void:
	fade_box.color = Color(0,0,0,255)
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_packed(next_scene)
