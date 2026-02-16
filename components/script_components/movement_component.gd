extends Node
class_name MovementComponent

@export var speed := 300.0
@export var acceleration := 2000.0
@export var friction := 2000.0

@export var controller : MovementController ## The controller is where the intent to move comes from. 
@onready var body := owner as CharacterBody2D ## The node that will actually be moving.

func _ready():
	assert(body, "MovementComponent must be owned by a CharacterBody2D or body does not exist")

func _physics_process(delta: float) -> void:
	if not body:
		return
	
	var movement_input : Vector2 = _get_movement_input()
	var target_velocity := movement_input * speed
	
	if movement_input != Vector2.ZERO:
		## Although lerp could be used, move_toward seems to function better.
		body.velocity = body.velocity.move_toward(
			target_velocity,
			acceleration * delta
		)
	else:
		body.velocity = body.velocity.move_toward(
			Vector2.ZERO,
			friction * delta
		)
		
	_apply_velocity_cleanup() ## Prevents jittering and micro movements.
	body.move_and_slide()

func _apply_velocity_cleanup():
	if body.velocity.length_squared() < 1.0:
		body.velocity = Vector2.ZERO

func _get_movement_input() -> Vector2:
	if not controller:
		print("No controller")
	else:
		return controller.get_movement_vector()
	return Vector2.ZERO
