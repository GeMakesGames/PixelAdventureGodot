extends PlayerBaseState

@onready var coyote_timer = $CoyoteTimer

func enter():
	object.animation_player.play("fall")
	if finite_state_machine.previous_state_name != "jump"\
		and finite_state_machine.previous_state_name != "doublejump"\
		and finite_state_machine.previous_state_name != "walljump":
		coyote_timer.start()

func physics_process(delta):
	gravity(delta)
	acceleration(delta)
	object.update_facing_direction()
	move_and_slide()
	if object.is_on_floor():
		var direction = object.input_manager.x
		if object.input_manager.jump_buffer:
			change_state("jump")
			object.land()
		elif direction == 0:
			change_state("idle")
		else:
			change_state("run")
	elif object.input_manager.jump_buffer and wall_check(Player.WALL_JUMP_DISTANCE) != 0:
		change_state("walljump")
	elif object.is_on_wall():
		change_state("wallslide")
	else:
		if not coyote_timer.is_stopped() and object.input_manager.jump_just_pressed:
			change_state("jump" if finite_state_machine.previous_state_name != "wallslide" else "walljump")
		elif object.can_double_jump and object.input_manager.jump_just_pressed:
			change_state("doublejump")

