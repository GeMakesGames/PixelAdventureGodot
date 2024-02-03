extends Node

signal score_changed

var main
var score = 0

func update_score(amount):
	score += amount
	score_changed.emit()
