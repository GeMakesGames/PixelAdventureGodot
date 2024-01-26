extends State

func enter():
	var animation
	match object.pattern_value:
		object.Direction.LEFT: animation = "left"
		object.Direction.RIGHT: animation = "right"
		object.Direction.UP: animation = "top"
		object.Direction.DOWN: animation = "bottom"
	object.animation_player.play(animation)

func physics_process(delta):
	if not object.animation_player.is_playing():
		object.update_pattern()
		if object.pattern_finish:
			change_state("idle")
		else:
			change_state("move")
