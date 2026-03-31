class_name LevelGeneration_Copilot extends Node3D

@export var room_scenes : Array[PackedScene]
@export var max_rooms : int

var spawn_transform : Transform3D = self.transform

func _ready() -> void:
	generate_rooms()

func generate_rooms() -> void:
	for i in max_rooms:
		var random = randi_range(0, room_scenes.size())
		
		var room = room_scenes.get(random)
		var room_i : RoomObject = room.instantiate()
		
		room_i.global_transform = spawn_transform
		spawn_transform = room_i.end_point.global_transform
		
		self.add_child(room_i)
		print(i + 1)