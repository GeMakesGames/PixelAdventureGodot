extends PlayerBaseState

func enter():
	object.animation_player.play("jump")
	object.velocity.y = -object.jump_suvat.u
	object.input_manager.jump_buffer = false
	var direction = wall_check(Player.WALL_JUMP_DISTANCE) * -1
	if direction == 0:
		direction = 1
	object.facing_direction = direction
	object.velocity.x = object.run_suvat.v * direction * 2.5

func physics_process(delta):
	gravity(delta, object.jump_suvat)
	acceleration(delta)
	object.update_facing_direction()
	move_and_slide()
	if object.velocity.y >= 0:
		change_state("fall")
