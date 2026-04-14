extends Node3D

@export var trigger_vol : TriggerVolume;
@export var car_node : Node3D;
@export var player : PlayerController;
@export var triggered : bool = false



func car_movement():
	var ts = get_tree().create_tween()
	ts.tween_property(car_node, "global_position", player.global_position, 2.5);

func _on_trigger_volume_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		triggered = true;

func _process(delta: float) -> void:
	if triggered:
		car_movement();
