extends PlayerBaseState

@onready var coyote_timer = $CoyoteTimer
var no_coyote_states = ["jump", "doublejump", "walljump", "launch"]
var exited

func enter():
	exited = false
	object.animation_player.play("fall")
	if not no_coyote_states.has(finite_state_machine.previous_state_name):
		coyote_timer.start()

func physics_process(delta):
	gravity(delta)
	acceleration(delta)
	object.update_facing_direction()
	move_and_slide()
	if exited: return
	var direction = object.input_manager.x
	if object.is_on_floor():
		if object.input_manager.jump_buffer:
			change_state("jump")
			object.land()
		elif direction == 0:
			change_state("idle")
		else:
			change_state("run")
	elif object.input_manager.jump_buffer and wall_check(Player.WALL_JUMP_DISTANCE) != 0:
		change_state("walljump")
	elif object.is_on_wall() and (object.get_wall_normal().x * -1 == direction):
		change_state("wallslide")
	else:
		if not coyote_timer.is_stopped() and object.input_manager.jump_just_pressed:
			change_state("jump" if finite_state_machine.previous_state_name != "wallslide" else "walljump")
		elif object.can_double_jump and object.input_manager.jump_just_pressed:
			change_state("doublejump")

func exit():
	exited = true
