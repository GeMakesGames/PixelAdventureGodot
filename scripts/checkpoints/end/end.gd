extends StaticBody2D
class_name End

@onready var sprite = $AnimatedSprite2D

func press(player):
	sprite.play("press")
	player.finite_state_machine.change_state("spawn")
