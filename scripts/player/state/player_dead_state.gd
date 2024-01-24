extends PlayerBaseState

func enter():
	object.animation_player.play("dead")

func physics_process(delta):
	if not object.animation_player.is_playing():
		object.died.emit(object);