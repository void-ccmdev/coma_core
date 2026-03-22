class_name FadeBox extends ColorRect

@export var fade_duration : float = 1.0 #DEFAULT

@export var fade_in_color : Color = Color(0,0,0,255)
@export var fade_out_color : Color = Color(0,0,0,0)

@export var fade_out_on_load : bool = false

func _ready() -> void:
	if fade_out_on_load:
		self.color = fade_in_color
		await get_tree().create_timer(2.0).timeout
		fade_out()

func fade_in() -> void:
	self.color = fade_out_color

	var ts = get_tree().create_tween()
	ts.tween_property(self, "color", fade_in_color, fade_duration)

func fade_out() -> void:
	self.color = fade_in_color

	var ts = get_tree().create_tween()
	ts.tween_property(self, "color", fade_out_color, fade_duration)