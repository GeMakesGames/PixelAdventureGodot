extends Node

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
		
var fruits_collected = {
	"apple" : 0,
	"bananas" : 0,
	"cherries" : 0,
	"kiwi" : 0,
	"melon" : 0,
	"orange" : 0,
	"pineapple" : 0,
	"strawberry" : 0
}

var deaths = 0

func start_run():
	for fruit in fruits_collected:
		fruits_collected[fruit] = 0
	deaths = 0

func pause():
	get_tree().paused = true
	main.pause_background.show()
	
func resume():
	get_tree().paused = false
	main.pause_background.hide()
