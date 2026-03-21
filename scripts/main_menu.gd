extends Node3D


@export var next_scene : PackedScene
@export var button_delay : float = 0.5

@export var github_link : String
@export var itchio_link : String
@export var twitter_link : String

func _ready() -> void:
	print(next_scene.resource_path)

####---UI-ELEMENTS---####

func _on_play_button_pressed() -> void:
	await get_tree().create_timer(button_delay).timeout
	get_tree().change_scene_to_packed(next_scene)

func _on_settings_button_pressed() -> void:
	pass # Replace with function body.

func _on_credits_button_pressed() -> void:
	pass # Replace with function body.

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
