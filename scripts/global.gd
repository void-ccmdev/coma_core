class_name GlobalScript extends Node

const DEFAULT_SENSITIVITY : float = 0.005
var current_sensitivity : float = DEFAULT_SENSITIVITY

var main_menu_scn : PackedScene = preload("res://scenes/main_menu.tscn")

func _input(_event: InputEvent) -> void:
    if Input.is_action_just_pressed("exit_debug"):
        get_tree().quit()