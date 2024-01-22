extends PlayerBaseState

@onready var coyote_timer = $CoyoteTimer

func enter():
	object.animation_player.play("fall")
	if finite_state_machine.previous_state_name != "jump":
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
		elif direction == 0:
			change_state("idle")
		else:
			change_state("run")
	else:
		if not coyote_timer.is_stopped() and object.input_manager.jump_just_pressed:
			change_state("jump")
