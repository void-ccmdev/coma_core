extends Node3D

@export var raycasts : Node3D
@export var end_walls : Node3D

func check_neighbors() -> void:
	for raycast : RayCast3D in raycasts.get_children():
		if !raycast.is_colliding():
			raycast.queue_free()
		else:

			var direction : String = raycast.name
			var wall_name : String = str("Wall" + direction)
			#print(wall_name)

			for wall : Node3D in end_walls.get_children():
				if wall.name == wall_name:
					wall.queue_free()

			raycast.queue_free()
	#print("Neighbors checked!")