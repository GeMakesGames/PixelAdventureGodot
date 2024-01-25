extends Node2D

@export var spawn : Vector2i

func _on_player_died(player):
	player.position = spawn
	player.finite_state_machine.change_state("spawn")
	player.facing_direction = 1
