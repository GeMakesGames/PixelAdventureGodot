extends State

var direction

func enter():
	object.get_parent().animation_player.play("on")

func physics_process(delta):
	direction = 1 if object.get_parent().has_riders else -1
	object.get_parent().path_follow.progress  = object.get_parent().path_follow.progress + delta * 20 * direction
	if (direction == 1 and object.get_parent().path_follow.progress_ratio == 1.0) or\
		(direction == -1 and object.get_parent().path_follow.progress_ratio == 0.0):
		change_state("off")
