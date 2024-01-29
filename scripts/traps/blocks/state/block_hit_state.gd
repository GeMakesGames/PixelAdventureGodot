extends State

func enter():
	object.animation_player.play("top" if object.hit_direction.y != 0 else "side")
	object.player.velocity += object.hit_direction * Vector2(400, 200)

func physics_process(_delta):
	if not object.animation_player.is_playing():
		object.collision_shape.set_deferred("disabled", true)
		object.queue_free()
