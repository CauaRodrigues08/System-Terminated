extends Node2D
class_name GunPivot

@export var aim_component : AimComponent
@export var radius : float = 50.0


func _process(_delta: float) -> void:
	if aim_component == null:
		return
	
	var direction = aim_component.get_aim_direction()
	
	if direction == Vector2.ZERO:
		return
	
	rotation = direction.angle()
	position = direction * radius
	print(self.position)
	
	if direction.x > 0:
		scale.y = 1
	else:
		scale.y = -1
	
