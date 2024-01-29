extends State

func enter():
	object.animation_player.play("blink")
	object.velocity = Vector2.ZERO
	
func physics_process(delta):
	object.velocity = object.velocity.move_toward(object.pattern_direction * object.move_suvat.v, object.move_suvat.a * delta)
	object.move_and_slide()
	for i in object.get_slide_collision_count():
		var collision_direction = object.get_slide_collision(i).get_normal() * -1
		if collision_direction == object.pattern_direction:
			change_state("hit")
			return
