extends CanvasLayer

@onready var animation_player = $AnimationPlayer

signal finished

var playing = false
var out = false

func fade_out():
	animation_player.play("fade_out")
	playing = true
	out = true

func fade_in():
	animation_player.play("fade_in")
	playing = true
	
func _process(_delta):
	if not playing: return
	if not animation_player.is_playing():
		playing = false
		if out:
			out = false
			Game.main.background.randomize_background()
		finished.emit()
		
