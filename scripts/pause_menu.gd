extends Control

@export var pause_ui : Control
@export var settings_ui : Control

####---FUNCTIONALITY---####

func _ready() -> void:
	if get_tree().paused && !self.visible:
		pause()
	elif !get_tree().paused && self.visible:
		resume()
		get_tree().debug_collisions_hint = true

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused:
			resume()
		else:
			pause()

####---CUSTOM-FUNCTIONS---####

func pause() -> void:
	get_tree().paused = true
	self.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
func resume() -> void:
	get_tree().paused = false
	self.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

####---UI-BUTTON-SIGNALS---####

func _on_resume_pressed() -> void:
	resume()

func _on_settings_pressed() -> void:
	pause_ui.hide()

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_packed(Global.main_menu_scn)

func _on_quit_pressed() -> void:
	get_tree().quit()
