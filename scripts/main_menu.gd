extends Node3D

@export var menu_ui : Control
@export var settings_ui : SettingsControl

@export var next_scene : PackedScene
@export var button_delay : float = 0.5

@export var github_link : String
@export var itchio_link : String
@export var twitter_link : String

func _ready() -> void:
	print(next_scene.resource_path)
	get_tree().paused = false
	hide_settings()

func _process(_delta: float) -> void:
	if settings_ui.should_hide:
		hide_settings()

####---CUSTOM-FUNCTIONS---####

func show_settings() -> void:
	settings_ui.show()
	menu_ui.hide()
	settings_ui.should_hide = false

func hide_settings() -> void:
	settings_ui.hide()
	menu_ui.show()
	settings_ui.should_hide = false

####---UI-ELEMENTS---####

func _on_play_button_pressed() -> void:
	await get_tree().create_timer(button_delay).timeout
	get_tree().change_scene_to_packed(next_scene)

func _on_settings_button_pressed() -> void:
	show_settings()

func _on_credits_button_pressed() -> void:
	await get_tree().create_timer(button_delay).timeout
	get_tree().change_scene_to_file("res://scenes/credits.tscn")

func _on_quit_button_pressed() -> void:
	await get_tree().create_timer(button_delay).timeout
	get_tree().quit()

####---LINKS---####


func _on_git_hub_pressed() -> void:
	OS.shell_open(github_link)

func _on_itch_io_pressed() -> void:
	OS.shell_open(itchio_link)

func _on_twitter_pressed() -> void:
	OS.shell_open(twitter_link)
