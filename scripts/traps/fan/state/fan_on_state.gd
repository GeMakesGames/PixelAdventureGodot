extends State

@onready var duration_timer = $DurationTimer
@onready var suvat = SUVAT.new(null, 0, 300, null, 1.0 / 60.0 * 15)

func enter():
	object.particles.emitting = true
	object.animation_player.play("on")
	duration_timer.start()
	
func physics_process(delta):
	if object.player:
		var player = object.player
		player.velocity = player.velocity.move_toward(Vector2(player.velocity.x, -suvat.v), delta  * suvat.a)
		
	if duration_timer.is_stopped():
		change_state("off")

func exit():
	object.particles.emitting = false
