extends ShootingController
class_name PlayerShootingInput

func wants_to_shoot() -> bool:
	return Input.is_action_just_pressed("shoot")
