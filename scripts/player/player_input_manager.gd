extends Node

@onready var jump_buffer_timer = $JumpBufferTimer

var x = 0
var jump_pressed = false
var jump_just_pressed = false:
	get:
		return jump_just_pressed
	set(value):
		jump_just_pressed = value
		if value:
			jump_buffer = true
var jump_buffer:
	get:
		return not jump_buffer_timer.is_stopped()
	set(value):
		if value: jump_buffer_timer.start()
		else: jump_buffer_timer.stop()
		
func update_input():
	x = Input.get_axis("left", "right")
	jump_just_pressed = Input.is_action_just_pressed("jump")
	jump_pressed = Input.is_action_pressed("jump")
