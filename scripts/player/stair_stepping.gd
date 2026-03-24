extends Node3D

@export var player : PlayerController
@export var wall_detector : ShapeCast3D
@export var stair_detector : ShapeCast3D
@export var stair_ground_detector : RayCast3D

@export_group("Settings")
@export var enable_stair_stepping : bool = true
@export var use_smooth_steps : bool = true
@export var step_offset : float = 0.1
@export var step_time : float = 0.05

func get_height_difference(stair_height: float) -> float:
	var height_difference
	height_difference = (stair_height - player.global_position.y)

	return height_difference 

func step(stair_height: float) -> void:
	if use_smooth_steps:
		get_tree().create_tween().tween_property(player,
												"global_position",
												Vector3(
													player.global_position.x,
													player.global_position.y + (get_height_difference(stair_height) + step_offset),
													player.global_position.z
												),
												step_time
											)

	else:
		player.global_position.y += get_height_difference(stair_height) + step_offset

func _process(_delta: float) -> void:
	if enable_stair_stepping == false || wall_detector.is_colliding():
		return
	
	if stair_detector.is_colliding():
		if abs(player.velocity.x + player.velocity.z) > 0:	 
			step(stair_detector.get_collision_point(0).y)
	
	if stair_ground_detector.is_colliding() && stair_ground_detector.get_collider().is_in_group("StairStep"):
		player.velocity.y -= 5
