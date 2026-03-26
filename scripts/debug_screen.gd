class_name DebugControl extends Control

@export var fps_enabled : bool = true
@export var gpos_enabled : bool = true
@export var player : PlayerController

@export_group("Children")
@export var ui_fps : Label
@export var ui_gpos : Label

func _process(_delta: float) -> void:
	if Global.debug_mode_enabled:
		self.show()
	else:
		self.hide()

	if fps_enabled:
		ui_fps.text = str("FPS:" + str(Engine.get_frames_per_second()))
	if gpos_enabled && player:
		ui_gpos.text = str("Position: " +
							" X: " + str("%0.2f" %player.global_position.x) + 
							" Y: " + str("%0.2f" %player.global_position.y) + 
							" Z: " + str("%0.2f" %player.global_position.z)
						)