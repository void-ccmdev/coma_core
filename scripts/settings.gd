extends Control

@export var vsync_btn : CheckButton
@export var fullscreen_btn : CheckButton

func _ready() -> void:
	pass

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
			