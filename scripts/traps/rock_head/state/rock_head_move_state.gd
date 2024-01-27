extends State

func enter():
	object.animation_player.play("blink")
	object.velocity = Vector2.ZERO
	
func physics_process(delta):
	object.velocity = object.velocity.move_toward(object.pattern_direction * object.move_suvat.v, object.move_suvat.a * delta)
	var collision = object.move_and_collide(object.velocity * delta)
	if collision:
		var collision_direction = collision.get_normal() * -1
		var body = collision.get_collider()
		if body is TileMap and collision_direction == object.pattern_direction:
			change_state("hit")
		
