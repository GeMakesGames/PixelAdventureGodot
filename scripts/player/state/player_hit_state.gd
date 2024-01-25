extends PlayerBaseState

@onready var timer = $Timer

func enter():
	object.animation_player.play("hit")
	object.velocity = Vector2(object.hit_direction * object.hit_suvat.v, -object.hit_fall_suvat.v)
	object.collision_shape.set_deferred("disabled", true)
	timer.start()

func physics_process(delta):
	gravity(delta, object.hit_fall_suvat)
	acceleration(delta, object.hit_direction)
	move_and_slide()

func exit():
	object.collision_shape.set_deferred("disabled", false)
	object.velocity = Vector2.ZERO

func _on_timer_timeout():
	object.died.emit(object);