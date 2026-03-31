extends Node3D

@export var credits : VBoxContainer
@export var pos : Vector2

func _ready() -> void:
	get_tree().paused = false
	print("CREDITS")
	pos = credits.position

func _process(_delta: float) -> void:
	pos.y -= 0.5
	get_tree().create_tween().tween_property(credits, "position", pos, 0.1)	
