extends Node3D

@export var modules : Array[PackedScene]
@export var module_container : Node3D
@export var level_scale_xz : int
@export var module_scale_xz : int

func _ready() -> void:
	generate_level()

func generate_level() -> void:
	var cursor : Vector3 = Vector3.ZERO

	for x in level_scale_xz:
		for z in level_scale_xz:
			generate_module(cursor)
			cursor.z += module_scale_xz

		cursor.x += module_scale_xz
		cursor.z = 0
	
	await get_tree().create_timer(0.1).timeout
	delete_extra_walls()
	
	print("Level generated!")

func generate_module(pos : Vector3) -> void: 
	var random : int = randi_range(1, modules.size())
	var module : PackedScene = modules.get(random - 1)
	var module_i : Node3D = module.instantiate()

	module_i.position = pos

	module_container.add_child(module_i)
	#print("Module generated!")

func delete_extra_walls() -> void:
	for module : Node3D in module_container.get_children():
		module.check_neighbors()
