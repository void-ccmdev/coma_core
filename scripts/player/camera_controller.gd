class_name CameraController extends Node3D

@export var max_look_up_angle : float = 85
@export var max_look_down_angle : float = -85

func _ready() -> void:
	print("Camera Controller loaded!")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		self.rotate_x(-event.relative.y * Global.current_sensitivity)

		self.rotation.x = clamp(
								self.rotation.x,				 #TARGET
								deg_to_rad(max_look_down_angle), #MIN
								deg_to_rad(max_look_up_angle)	 #MAX
							)