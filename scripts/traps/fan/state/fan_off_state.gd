extends State

@onready var cd_timer = $CooldownTimer

func enter():
	object.animation_player.play("off")
	cd_timer.start()
	
func physics_process(delta):
	if cd_timer.is_stopped():
		change_state("on")
