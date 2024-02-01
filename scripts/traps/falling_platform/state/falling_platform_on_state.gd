extends State

var down

var velocity

func enter():
	down = true
	velocity = Vector2.ZERO
	object.animation_player.play("on")
	object.particles.emitting = true

func physics_process(delta):
	if not object.delay_timer.is_stopped(): return
	var dir = Vector2.DOWN if down else Vector2.UP
	velocity =+ delta * 500 * dir.y
	object.position.y += velocity * delta
	
	if down and object.position.y >= object.offset.y:
		down = false
		velocity = Vector2.ZERO
	elif not down and object.position.y <= object.original_position.y:
		down = true
		velocity = Vector2.ZERO
