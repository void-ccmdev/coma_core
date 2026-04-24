extends StaticBody3D
class_name Door

@export var door_node : Node3D
@export var message : String
@export var closed : bool = false
@export var locked: bool
@export var interact_collison : CollisionShape3D
@export var door_movement_duration : float = 0.5

@export var open_rot_y : float = -105.0
@export var close_rot_y : float = 0.0

func _ready() -> void:
	if closed:
		close()
	else:
		open()

func interact() -> void:
	if !locked:
		if closed:
			open()
		else:
			close()
		
	else:
		message = "Locked"

func close() -> void:
	var ts = get_tree().create_tween()
	ts.tween_property(door_node, "rotation", Vector3(0, deg_to_rad(close_rot_y), 0), door_movement_duration)
	ts.set_parallel()
	ts.tween_property(interact_collison, "rotation", Vector3(0, deg_to_rad(close_rot_y), 0), door_movement_duration)
	closed = true
	message = "Open"

func open() -> void:
	var ts = get_tree().create_tween()
	ts.tween_property(door_node, "rotation", Vector3(0, deg_to_rad(open_rot_y), 0), door_movement_duration)
	ts.set_parallel()
	ts.tween_property(interact_collison, "rotation", Vector3(0, deg_to_rad(open_rot_y), 0), door_movement_duration)
	closed = false
	message = "Close"