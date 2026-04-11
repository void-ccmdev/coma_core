class_name Flashlight extends SpotLight3D


@export var on : bool = true
@export var unlocked : bool = true

@export_group("Settings")
@export var parent : Camera3D
@export var enable_smoothing : bool = true
@export var smoothing_power : float = 0.125 #Default
@export var use_audio : bool = true
@export var audio_node : AudioStreamPlayer3D

func _ready() -> void:
	print("Flashlight Script Loaded!")

	if on && unlocked:
		self.show()
	else:
		self.hide()

func fl_click() -> void:
	if use_audio && audio_node:
		var random = randf_range(0.85, 1.15)
		audio_node.pitch_scale = random
		audio_node.stop()
		audio_node.play()
		
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("flashlight") && unlocked:
		if on:
			self.hide()
			on = false
			fl_click()
		else:
			self.show()
			on = true
			fl_click()

func _process(_delta: float) -> void:
	if enable_smoothing:
		self.top_level = true
		get_tree().create_tween().tween_property(
												self,
												"global_transform", 
												parent.global_transform, 
												smoothing_power
											)
	else:
		self.top_level = false