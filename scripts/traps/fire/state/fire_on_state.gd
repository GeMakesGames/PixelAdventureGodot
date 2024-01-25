extends State

@onready var timer = $Timer

func enter():
	object.animation_player.play("on")
	object.fire_area_collision_shape.set_deferred("disabled", false)

func physics_process(delta):
	if timer.is_stopped() && not object.step_area.has_overlapping_bodies():
		timer.start()
#func exit():
	object.fire_area_collision_shape.set_deferred("disabled", true)

func _on_timer_timeout():
	change_state("off")
