extends Button

@export var enable_audio : bool = true
@export_group("Settings")
@export var hover_audio : AudioStreamPlayer
@export var unhover_audio : AudioStreamPlayer
@export var press_audio : AudioStreamPlayer

func _ready() -> void:
	if is_inside_tree():
		self.mouse_entered.connect(on_hover)
		self.mouse_exited.connect(on_unhover)
		self.button_down.connect(on_press)
		self.button_up.connect(on_press)

func randomize_audio_pitch(audio : AudioStreamPlayer) -> void:
	var random = randf_range(0.85, 1.15)
	audio.pitch_scale = random

func on_hover() -> void:
	if enable_audio && hover_audio:
		hover_audio.stop()
		randomize_audio_pitch(hover_audio)
		hover_audio.play()

func on_unhover() -> void:
	if enable_audio && unhover_audio:
		unhover_audio.stop()
		randomize_audio_pitch(unhover_audio)
		unhover_audio.play()

func on_press() -> void:
	if enable_audio && press_audio:
		press_audio.stop()
		randomize_audio_pitch(press_audio)
		press_audio.play()