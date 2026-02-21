extends CharacterBody2D

func _ready() -> void:
	## Movement
	$MovementComponent.controller = $PlayerMovementInput
	
	## Aiming
	$AimComponent.controller = $PlayerAimInput
	$GunPivot.aim_component = $AimComponent
