extends State

func enter():
	object.animation_player.play("hit")

func physics_process(delta):
	if not object.animation_player.is_playing():
		change_state("on")
