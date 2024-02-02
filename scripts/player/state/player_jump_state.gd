extends PlayerBaseState

var variable_jump_height

func enter():
	object.animation_player.play("jump")
	object.velocity.y = -object.jump_suvat.u
	object.input_manager.jump_buffer = false
	# apply a little horizontal boost so the player can gain frames
	object.velocity.x += object.input_manager.x * (object.run_suvat.v / 2)
	variable_jump_height = false
	object.emit_jump_particles()

func physics_process(delta):
	gravity(delta, object.jump_suvat)
	acceleration(delta)
	object.update_facing_direction()
	move_and_slide()
	if not variable_jump_height and not object.input_manager.jump_pressed:
		variable_jump_height = true
		if object.velocity.y <= 0:
			object.velocity.y /= 2;
	if object.velocity.y >= 0:
		change_state("fall")
