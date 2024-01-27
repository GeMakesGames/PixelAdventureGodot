extends State

func enter():
	object.animation_player.play("jump")
	object.player.velocity.y = -575
	object.player.finite_state_machine.change_state("launch")
	
func physics_process(_delta):
	if not object.animation_player.is_playing():
		change_state("idle")
