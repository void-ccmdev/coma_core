extends Node3D

@export var trigger_vol : TriggerVolume;
@export var car_node : Node3D;
@export var player : PlayerController;
@export var triggered : bool = false
@export var car_trigger : TriggerVolume;
@export var plr_hit = false;
@export var fade_box : FadeBox;
@export var trigger_pos : Vector3;

@export var next_scene : PackedScene

func _ready() -> void:
	pass

func car_movement():
	var ts = get_tree().create_tween()
	ts.tween_property(car_node, "global_position", trigger_pos, 0.75);
	if plr_hit:
		ts.kill()
		ts.stop()

func _on_trigger_volume_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player") && is_inside_tree():
		triggered = true;
		trigger_pos = body.global_position

func _process(_delta: float) -> void:
	if triggered:
		car_movement();
	if plr_hit:
		plr_hit = false
		fade_box.color = Color(0,0,0,1);
		await get_tree().create_timer(2.5).timeout;
		get_tree().change_scene_to_packed(next_scene);


func _on_car_trigger_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player") && is_inside_tree():
		plr_hit = true;
