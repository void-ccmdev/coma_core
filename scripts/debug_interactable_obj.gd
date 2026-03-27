extends StaticBody3D

@export var message : String = "BOX"

func interact() -> void:
	self.scale += Vector3.ONE