class_name CameraEffects extends Camera3D

@export var player : PlayerController

@export_category("Effects")
@export var enable_tilt : bool = true

@export_group("Tilt Settings")
@export var run_pitch : float = 0.1
@export var run_roll : float = 0.26
@export var max_pitch : float = 1.0
@export var max_roll : float = 2.5

func _process(_delta: float) -> void:
	calculate_view_offset()

func calculate_view_offset() -> void:
	if !player:
		return

	var velocity = player.velocity

	var angles = Vector3.ZERO

	# Camera Tilt

	if enable_tilt:
		var forward = global_transform.basis.z
		var right = global_transform.basis.x

		var forward_dot = velocity.dot(forward)
		var forward_tilt = clampf(forward_dot * deg_to_rad(run_pitch), deg_to_rad(-max_pitch), deg_to_rad(max_pitch))
		angles.x += forward_tilt

		var right_dot = velocity.dot(right)
		var side_tilt = clampf(right_dot * deg_to_rad(run_roll), deg_to_rad(-max_roll), deg_to_rad(max_roll))
		angles.z -= side_tilt

	create_tween().tween_property(self, "rotation", angles, 0.3)