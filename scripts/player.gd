extends CharacterBody2D

func _ready() -> void:
	$MovementComponent.controller = $PlayerInputComponent
	## This way, MovementComponent will have a controller, even if it's created dinamically.
	$AimComponent.controller = $PlayerAimInput
	$GunPivot.aim_component = $AimComponent
