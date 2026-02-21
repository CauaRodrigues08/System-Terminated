extends CharacterBody2D

func _ready() -> void:
	## Movement
	$MovementComponent.controller = $PlayerInputComponent
	## This way, MovementComponent will have a controller, even if it's created dinamically.
	
	## Aiming
	$AimComponent.controller = $PlayerAimInput
	$GunPivot.aim_component = $AimComponent
