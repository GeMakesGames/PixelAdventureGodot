extends Node2D

@onready var checkpoints = $Checkpoints

func _ready():
	Game.player.died.connect(_on_player_died)

func _on_player_died():
	Game.main.transition.fade_out()
	Game.player.visible = false
	await Game.main.transition.finished
	Game.main.transition.fade_in()
	await Game.main.transition.finished
	Game.player.global_position = checkpoints.active_checkpoint.get_spawn_position()
	Game.player.finite_state_machine.change_state("spawn")
	Game.player.facing_direction = 1
	Game.deaths += 1
