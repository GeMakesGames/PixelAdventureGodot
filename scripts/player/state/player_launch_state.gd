extends PlayerBaseState

func enter():
	object.velocity = object.launch_velocity
	if object.launch_velocity.y <= 0:
		object.emit_launch_particles()
	object.animation_player.play("jump")
	object.land()

func physics_process(delta):
	gravity(delta, object.jump_suvat)
	acceleration(delta)
	object.update_facing_direction()
	move_and_slide()
	if object.velocity.y >= 0:
		change_state("fall")
