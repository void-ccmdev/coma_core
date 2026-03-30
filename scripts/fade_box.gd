class_name FadeBox extends ColorRect

@export var fade_color : Color = Color(0,0,0,255)
@export var fade_on_load : bool = false 

func _ready() -> void:
	if fade_on_load:
		self.fade_out()

func fade_in() -> void:
	self.color = Color(0,0,0,0)
	create_tween().tween_property(self, "color", fade_color, 0.7)
func fade_out() -> void:
	self.color = fade_color
	create_tween().tween_property(self, "color", Color(0,0,0,0), 0.7)