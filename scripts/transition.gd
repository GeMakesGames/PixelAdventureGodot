extends CanvasLayer

@onready var animation_player = $AnimationPlayer

signal finished

var playing = false

func fade_out():
	animation_player.play("fade_out")
	playing = true

func fade_in():
	animation_player.play("fade_in")
	playing = true
	
func _process(delta):
	if not playing: return
	if not animation_player.is_playing():
		playing = false
		finished.emit()
