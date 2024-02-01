extends PlayerBaseState

func enter():
	object.animation_player.play("jump")
	object.land()

func physics_process(delta):
	gravity(delta, object.jump_suvat)
	acceleration(delta)
	object.update_facing_direction()
	move_and_slide()
	print(object.velocity)
	if object.velocity.y >= 0:
		change_state("fall")
