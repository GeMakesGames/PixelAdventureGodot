extends State
class_name PlayerBaseState

func gravity(delta, suvat = object.fall_suvat):
	object.velocity = object.velocity.move_toward(Vector2(object.velocity.x, suvat.v), suvat.a * delta)

func acceleration(delta, direction = object.input_manager.x):
	var current_direction = signi(object.velocity.x)
	var suvat = object.run_suvat
	if direction == 0 or (current_direction != 0 and current_direction != direction):
		suvat = object.stop_suvat
	object.velocity = object.velocity.move_toward(Vector2(object.run_suvat.v * direction, object.velocity.y), suvat.a * delta)

func move_and_slide():
	object.move_and_slide()
