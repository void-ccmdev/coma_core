extends Node3D
class_name door

@export var door_node : Node3D
@export var message : String
@export var closed : bool = false

func interact() -> void:
	if closed:
		open()
	else:
		close()

func close() -> void:
	
	closed = true

func open() -> void:
	closed = false