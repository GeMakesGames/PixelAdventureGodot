extends PlayerBaseState

func enter():
	object.animation_player.play("double_jump")
	object.velocity.y = -object.jump_suvat.u * .80
	object.input_manager.jump_buffer = false
	object.can_double_jump = false

func physics_process(delta):
	gravity(delta, object.jump_suvat)
	acceleration(delta)
	object.update_facing_direction()
	move_and_slide()
	if object.velocity.y >= 0:
		change_state("fall")
