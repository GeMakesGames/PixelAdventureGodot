extends PlayerBaseState

func enter():
	object.animation_player.play("idle")
	if finite_state_machine.previous_state_name == "fall":
		object.land()

func physics_process(delta):
	var direction = object.input_manager.x;
	gravity(delta)
	acceleration(delta, direction)
	object.update_facing_direction(direction)
	move_and_slide()
	if not object.is_on_floor():
		change_state("fall")
	elif object.input_manager.jump_just_pressed:
		change_state("jump")
	elif direction != 0:
		change_state("run")
