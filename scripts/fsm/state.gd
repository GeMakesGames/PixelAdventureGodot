extends Node
class_name State

var finite_state_machine
var object

func enter():
	pass
	
func exit():
	pass

func physics_process(_delta):
	pass
	
func process(_delta):
	pass

func change_state(next_state_name):
	finite_state_machine.change_state(next_state_name)
