extends Node

signal score_changed

var main
var player :
	get:
		return player.get_ref() if player != null else null
	set(value):
		player = weakref(value)

var camera :
	get:
		return camera.get_ref() if camera != null else null
	set(value):
		camera = weakref(value)
		
#rework later
var score = 0

func update_score(amount):
	score += amount
	score_changed.emit()

func pause():
	get_tree().paused = true
	main.pause_background.show()
	
func resume():
	get_tree().paused = false
	main.pause_background.hide()
