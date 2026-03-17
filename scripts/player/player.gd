class_name PlayerController extends CharacterBody3D

@export_group("Abilities")
@export var can_sprint : bool = true

@export_group("Settings")
@export var walk_speed : float = 3.5
@export var sprint_speed : float = 7.5
@export var jump_power : float = 5.75

@export var current_speed : float

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	print("Player Controller loaded!")

func _input(event: InputEvent) -> void:
	if  event is InputEventMouseMotion:
		self.rotate_y(-event.relative.x * Global.current_sensitivity)

	if can_sprint:
		if Input.is_action_pressed("sprint"):
			current_speed = sprint_speed
		else:
			current_speed = walk_speed
		

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_power

	var input_dir := Input.get_vector("left", "right", "front", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	move_and_slide()
