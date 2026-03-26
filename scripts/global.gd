class_name GlobalScript extends Node

const DEFAULT_SENSITIVITY : float = 0.005
var current_sensitivity : float = DEFAULT_SENSITIVITY

var main_menu_scn : PackedScene = preload("res://scenes/main_menu.tscn")

var debug_mode_enabled = false

func _input(_event: InputEvent) -> void:
    if Input.is_action_just_pressed("exit_debug"):
        get_tree().quit()
    
    if Input.is_action_just_pressed("debug"):
        if debug_mode_enabled: debug_mode_enabled = false
        else: debug_mode_enabled = true