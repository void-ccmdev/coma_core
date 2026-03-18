class_name Flashlight extends SpotLight3D


@export var on : bool = true

@export_group("Settings")
@export var parent : Camera3D
@export var enable_smoothing : bool = true
@export var smoothing_power : float = 0.125 #Default

func _ready() -> void:
	print("Flashlight Script Loaded!")

	if on:
		self.show()
	else:
		self.hide()

			
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("flashlight"):
		if on:
			self.hide()
			on = false
		else:
			self.show()
			on = true

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