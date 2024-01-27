extends State

@onready var timer = $Timer

func enter():
	object.animation_player.play("idle")
	object.reset_pattern();
	timer.start()
	
func physics_process(_delta):
	if timer.is_stopped():
		
		change_state("move")

func exit():
	object.update_pattern()
