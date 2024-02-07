extends Node2D

@onready var resource_preloader = $ResourcePreloader

var current_level

func load_level(level_name):
	Game.pause()
	if current_level:
		current_level.set_process_input(false)
	var transition = Game.main.transition
	if transition.state == 0:
		transition.fade_out()
		await transition.finished
	if current_level:
		current_level.queue_free()
	Game.resume()
	current_level = resource_preloader.get_resource(level_name).instantiate()
	add_child(current_level)
	transition.fade_in()
	await transition.finished
	Game.player.finite_state_machine.change_state("spawn")

func unload_current_level():
	current_level.queue_free()
	current_level = null
