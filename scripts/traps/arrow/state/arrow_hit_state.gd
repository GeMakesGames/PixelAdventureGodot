extends State

@onready var timer = $Timer


func enter():
	object.animation_player.play("hit")
	object.collision_shape.set_deferred("disabled", true)
	timer.start()

func physics_process(_delta):
	if timer.is_stopped():
		change_state("spawn")
