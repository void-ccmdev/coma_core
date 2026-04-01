class_name  LevelGeneration extends Node3D

@export var room_scenes : Array[PackedScene]
@export var max_rooms : int

var spawn_pos : Vector3
var spawn_rot : Vector3

var dirs_right : int = 0
var dirs_left : int = 0

func _ready() -> void:
	spawn_pos = self.global_position
	spawn_rot = self.global_rotation

	generate()

func generate() -> void:
	for i in max_rooms:
		await get_tree().create_timer(.5).timeout
		generate_room()

		print("left: " + str(dirs_left) +" --- " + "right: " + str(dirs_right))

func generate_room() -> void:
		var random = randi_range(1,room_scenes.size())

		var room : PackedScene = room_scenes.get(random - 1)
		var room_i : RoomObject = room.instantiate()

		if room_i.direction == "":pass
		elif room_i.direction == "right" && dirs_right < 2:
			dirs_right += 1
			if !dirs_left < 0: dirs_left -= 1
		elif room_i.direction == "left" && dirs_left < 2:
			dirs_left += 1
			if !dirs_right < 0: dirs_right -= 1
		else:
			if dirs_right == 2 || dirs_left == 2:
				room_i.queue_free()
				generate_room()
			return
		
			

		self.add_child(room_i)
	
		room_i.global_position = spawn_pos
		room_i.global_rotation = spawn_rot

		spawn_pos = room_i.end_point.global_position
		spawn_rot = room_i.end_point.global_rotation
