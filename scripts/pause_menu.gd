extends Control

@export var pause_ui : Control
@export var settings_ui : SettingsControl
@export var fade_box : FadeBox
@export var button_delay : float = 0.8

####---FUNCTIONALITY---####

func _ready() -> void:
	if get_tree().paused && !self.visible:
		pause()
	elif !get_tree().paused && self.visible:
		resume()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused:
			resume()
		else:
			pause()

func _process(_delta: float) -> void:
	if settings_ui.should_hide:
		hide_settings()

####---CUSTOM-FUNCTIONS---####

func pause() -> void:
	get_tree().paused = true
	self.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	hide_settings()
	
func resume() -> void:
	get_tree().paused = false
	self.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func show_settings() -> void:
	pause_ui.hide()
	settings_ui.show()
	settings_ui.should_hide = false
func hide_settings() -> void:
	pause_ui.show()
	settings_ui.hide()
	settings_ui.should_hide = false

####---UI-BUTTON-SIGNALS---####

func _on_resume_pressed() -> void:
	resume()

func _on_settings_pressed() -> void:
	show_settings()

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	fade_box.fade_in()
	await get_tree().create_timer(button_delay).timeout
	get_tree().change_scene_to_packed(Global.main_menu_scn)

func _on_quit_pressed() -> void:
	get_tree().paused = false
	fade_box.fade_in()
	await get_tree().create_timer(button_delay).timeout
	get_tree().quit()
