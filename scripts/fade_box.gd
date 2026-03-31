class_name FadeBox extends ColorRect

@export var fade_color : Color = Color(0,0,0,255)
@export var fade_on_load : bool = false 
@export var on_load_delay : float = 0.5

func _ready() -> void:
	if fade_on_load:
		self.color = fade_color
		await get_tree().create_timer(on_load_delay).timeout
		self.fade_out()

func fade_in() -> void:
	self.color = Color(0,0,0,0)
	create_tween().tween_property(self, "color", fade_color, 0.7)
func fade_out() -> void:
	self.color = fade_color
	create_tween().tween_property(self, "color", Color(0,0,0,0), 0.7)