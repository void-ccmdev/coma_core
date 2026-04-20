extends Node3D
class_name kw_hospital_module

@export var raycasts : Node3D
@export var end_walls : Node3D
@export var has_neighbors : bool
@export var room_module : bool
@export var mainstream_related : bool = false
@export var plr_spawn_spot : Marker3D

func check_neighbors() -> void:
	for raycast : RayCast3D in raycasts.get_children():
		if !raycast.is_colliding():
			raycast.queue_free()
		else:
			has_neighbors = true

			var direction : String = raycast.name
			var wall_name : String = str("Wall" + direction)
			#print(wall_name)

			for wall : Node3D in end_walls.get_children():
				if wall.name == wall_name:
					wall.queue_free()

			check_mainstream_relation(raycast)
			raycast.queue_free()
	
	if !has_neighbors || !mainstream_related:
		self.queue_free()
	
	#print("Neighbors checked!")

func get_neighbor_root_module(collider : Node3D) -> kw_hospital_module:
	var node = collider.get_parent()

	while !node is kw_hospital_module:
		node = node.get_parent()

	var root : Node3D = node
	return root

func check_mainstream_relation(raycast: RayCast3D) -> void:
	if get_neighbor_root_module(raycast.get_collider()).mainstream_related:
		self.mainstream_related = true
