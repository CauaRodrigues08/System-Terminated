extends Node
class_name AimComponent

@export var body : Node2D
@export var controller : AimController

var aim_direction : Vector2 = Vector2.RIGHT

func _process(_delta: float) -> void:
	if controller == null or body == null:
		return
	
	var new_direction = controller.get_aim_direction(body.global_position)
	
	if new_direction != Vector2.ZERO:
		aim_direction = new_direction

func get_aim_direction() -> Vector2:
	return aim_direction
