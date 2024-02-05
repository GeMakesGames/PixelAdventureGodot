extends PlayerBaseState

func enter():
	object.animation_player.play("desappear")

func physics_process(_delta):
	if not object.animation_player.is_playing():
		object.disappeared.emit(object);
