class_name SettingsControl extends Control

@export var vsync_btn : CheckButton
@export var fullscreen_btn : CheckButton
@export var debug_btn : CheckButton

@export var back_btn : Button
@export var should_hide : bool = false

func _on_v_sync_pressed() -> void:
	print("V-Sync enabled = " + str(vsync_btn.button_pressed))

	if vsync_btn.button_pressed:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func _on_fullscreen_pressed() -> void:
	
	print("Fullscreen enabled = " + str(fullscreen_btn.button_pressed))

	if fullscreen_btn.button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			

func _on_back_btn_pressed() -> void:
	should_hide = true

func _on_debug_mode_pressed() -> void:
	print("V-Sync enabled = " + str(debug_btn.button_pressed))

	if debug_btn.pressed:
		Global.debug_mode_enabled = true
	else:
		Global.debug_mode_enabled = false
