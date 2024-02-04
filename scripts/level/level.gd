extends Node2D

@export var spawn : Vector2i

func _on_player_died(player):
	Game.main.transition.fade_out()
	player.visible = false
	await Game.main.transition.finished
	Game.main.transition.fade_in()
	await Game.main.transition.finished
	player.position = spawn
	player.finite_state_machine.change_state("spawn")
	player.facing_direction = 1
