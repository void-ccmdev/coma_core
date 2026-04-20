extends Node3D

@export var modules : Array[PackedScene]
@export var module_container : Node3D
@export var level_scale_xz : int
@export var module_scale_xz : int
@export var spawn_spot : Vector3
@export var player : PlayerController

var spawn_candidates : Array[kw_hospital_module]

func _ready() -> void:
	generate_level()
	await get_tree().create_timer(0.5).timeout
	player.global_position = pick_random_spawn_candidate(spawn_candidates)

func generate_level() -> void:
	var cursor : Vector3 = Vector3.ZERO

	for x in level_scale_xz:
		for z in level_scale_xz:
			generate_module(cursor)

			cursor.z += module_scale_xz

		cursor.x += module_scale_xz
		cursor.z = 0
	
	module_container.get_child(0).mainstream_related = true
	
	await get_tree().create_timer(0.5).timeout
	delete_extra_walls()

	print("Level generated!")

func generate_module(pos : Vector3) -> void: 
	var random : int = randi_range(1, modules.size())
	var module : PackedScene = modules.get(random - 1)
	var module_i : kw_hospital_module = module.instantiate()
	var random_rotation_y

	random = randi_range(1,3)
	
	if random == 1:
		random_rotation_y = 90
	elif random == 2:
		random_rotation_y = 180
	elif random == 3:
		random_rotation_y = 270
	else:
		random_rotation_y = 0
	
	if module_i.room_module:
		module_i.rotation.y = deg_to_rad(random_rotation_y)
	module_i.position = pos

	module_container.add_child(module_i)

	if module_i.room_module:
		spawn_candidates.append(module_i)
	#print("Module generated!")

func delete_extra_walls() -> void:
	for module : Node3D in module_container.get_children():
		await get_tree().create_timer(0.2).timeout
		module.check_neighbors()

func pick_random_spawn_candidate(candidate_array : Array) -> Vector3:
	var random = randi_range(0, candidate_array.size())
	spawn_spot = candidate_array.get(random -1).plr_spawn_spot.global_position

	return spawn_spot
