extends State

func enter():
	object.get_parent().animation_player.play("off")

func physics_process(_delta):
	if (object.get_parent().has_riders and object.get_parent().path_follow.progress_ratio != 1.0) or\
		(not object.get_parent().has_riders and object.get_parent().path_follow.progress_ratio == 1.0):
		change_state("on")
