extends PlayerBaseState

func enter():
	object.animation_player.play("spawn")

func physics_process(_delta):
	if not object.animation_player.is_playing():
		object.velocity = Vector2.ZERO
		move_and_slide()
		if object.is_on_floor():
			change_state("idle")
		else:
			change_state("fall")

func exit():
	object.can_double_jump = true
