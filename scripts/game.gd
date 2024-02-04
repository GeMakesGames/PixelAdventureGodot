extends Node

signal score_changed

var main
var player :
	get:
		return player.get_ref() if player != null else null
	set(value):
		player = weakref(value)
		
#rework later
var score = 0

func update_score(amount):
	score += amount
	score_changed.emit()
