extends PlayerBaseState

func enter():
	object.animation_player.play("spawn")

func physics_process(delta):
	if not object.animation_player.is_playing():
		object.velocity = Vector2.ZERO
		move_and_slide()
		if object.is_on_floor():
			change_state("idle")
		else:
			change_state("fall")