extends State

@onready var timer = $Timer

func enter():
	object.animation_player.play("off")
	timer.start()
	
func physics_process(delta):
	object.velocity = object.velocity.move_toward(Vector2(object.velocity.x, object.fall_suvat.v), object.fall_suvat.a * delta)
	object.move_and_collide(object.velocity * delta)
	if timer.is_stopped():
		object.queue_free()
