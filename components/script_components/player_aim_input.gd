extends AimController
class_name PlayerAimInput

enum Device { MOUSE, JOYSTICK }
@export var joystick_deadzone : float = 0.2
@export var mouse_threshold : float = 2.0

var last_used_device : Device = Device.MOUSE
var last_mouse_position : Vector2

func _ready() -> void:
	last_mouse_position = get_mouse_position()

func get_raw_joystick_vector() -> Vector2:
	return Vector2(
		Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left"),
		Input.get_action_strength("aim_down") -Input.get_action_strength("aim_up")
	)

func get_mouse_position() -> Vector2:
	return get_viewport().get_camera_2d().get_global_mouse_position()
	

func update_last_device() -> void:
	## joystick
	var joystick_vector = get_raw_joystick_vector()
	
	if joystick_vector.length() > joystick_deadzone:
		last_used_device = Device.JOYSTICK
		return
	
	## mouse
	var mouse_position = get_mouse_position()
	if mouse_position.distance_to(last_mouse_position) > mouse_threshold:
		last_used_device = Device.MOUSE
	
	last_mouse_position = mouse_position

func get_joystick_direction() -> Vector2:
	var joystick_vector = get_raw_joystick_vector()
	
	if joystick_vector.length() > joystick_deadzone:
		return joystick_vector.normalized()
	
	return Vector2.ZERO

func get_mouse_direction(origin: Vector2, mouse_position: Vector2) -> Vector2:
	var direction = mouse_position - origin
	
	if direction == Vector2.ZERO:
		return Vector2.ZERO
	
	return direction.normalized()
	

func get_aim_direction(origin: Vector2) -> Vector2:
	update_last_device()
	
	var mouse_position = get_mouse_position()
	
	match last_used_device:
		Device.JOYSTICK:
			return get_joystick_direction()
			
		Device.MOUSE:
			return get_mouse_direction(origin, mouse_position)
			
		
	return Vector2.ZERO
