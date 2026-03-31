class_name  LevelGeneration extends Node3D

@export var room_scenes : Array[PackedScene]
@export var max_rooms : int

var spawn_transform : Transform3D = self.transform

func _ready() -> void:
	generate_rooms()

func generate_rooms() -> void:
	for i  in max_rooms:
		var random = randi_range(0, max_rooms)

		for room_num in room_scenes.size():
			if room_num == random:
				var room = room_scenes.get(room_num)
				var room_i : RoomObject = room.instantiate()

				room_i.global_transform = spawn_transform
				spawn_transform = room_i.end_point.global_transform

				self.add_child(room_i)
		print(i+1)
