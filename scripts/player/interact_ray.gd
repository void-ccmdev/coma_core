class_name InteractRay extends RayCast3D

var collider = null

@export var ui_crosshair : Control
@export var ui_message : Label

func _process(_delta: float) -> void:
	if self.is_colliding() && self.get_collider().is_in_group("Interactable"):
		collider = self.get_collider()

		ui_crosshair.show()
		ui_message.text = collider.message

		if Input.is_action_just_pressed("interact"):
			collider.interact()
	else:
		collider = null
		ui_crosshair.hide()
		ui_message.text = ""