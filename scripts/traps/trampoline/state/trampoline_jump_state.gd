extends State

func enter():
	object.collision_shape.set_deferred("disabled", true)
	object.animation_player.play("jump")
	object.player.launch(Vector2(object.player.velocity.x, -575))
	
func physics_process(_delta):
	if not object.animation_player.is_playing():
		change_state("idle")

func exit():
	object.collision_shape.set_deferred("disabled", false)
