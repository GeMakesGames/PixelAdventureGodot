extends StaticBody2D
class_name End

@export var destination : String
@onready var sprite = $AnimatedSprite2D

func press(player):
	sprite.play("press")
	player.finite_state_machine.change_state("disappear")
	await player.disappeared
	await get_tree().create_timer(.5).timeout
	if destination:
		Game.main.world.load_level(destination)
	else:
		Game.main.summary.show_summary()
