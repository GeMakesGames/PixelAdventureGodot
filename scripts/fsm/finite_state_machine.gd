extends Node
class_name FiniteStateMachine

var states = {}
var current_state
var current_state_name
var previous_state_name

@export var debug := false

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.object = get_parent()
			child.finite_state_machine = self

func change_state(next_state_name):
	if current_state:
		current_state.exit()
		previous_state_name = current_state_name
	current_state_name = next_state_name.to_lower()
	current_state = states[current_state_name]
	current_state.enter()
	if debug:
		print("%s - %s -> %s" % [current_state.object.name, previous_state_name, current_state_name])

func physics_process(delta):
	if not current_state: return
	current_state.physics_process(delta)
	
func process(delta):
	if not current_state: return
	current_state.process(delta)
