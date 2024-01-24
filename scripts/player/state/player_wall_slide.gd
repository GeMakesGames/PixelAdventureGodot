extends PlayerBaseState

var direction

func enter():
	object.animation_player.play("wall_slide")
	object.velocity.x = 0
	direction = object.get_wall_normal().x * -1
	object.facing_direction = direction
	
func physics_process(delta):
	var suvat = object.wall_slide_suvat if object.velocity.y <= object.wall_slide_suvat.v else\
		object.wall_slide_overspeed_suvat
	gravity(delta, suvat)
	move_and_slide()
	var input_vector = object.input_manager.vector
	if object.input_manager.jump_just_pressed:
		change_state("walljump")
	elif input_vector != Vector2.ZERO && input_vector != Vector2.UP\
		&& input_vector.x != direction:
		if object.is_on_floor():
			change_state("idle")
		else:
			change_state("fall")
	elif not object.test_move(object.get_transform(), Vector2(direction, 0)):
		if object.is_on_floor():
			change_state("idle")
		else:
			change_state("fall")
	elif object.is_on_floor():
		change_state("idle")
