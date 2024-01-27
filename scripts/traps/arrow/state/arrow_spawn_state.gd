extends State

func enter():
	object.animation_player.play("spawn")

func physics_process(_delta):
	if not object.animation_player.is_playing():
		change_state("idle")

func exit():
	object.collision_shape.set_deferred("disabled", false)
