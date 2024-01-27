extends AnimatableBody2D

enum Direction {LEFT, RIGHT, UP, DOWN}

@onready var finite_state_machine = $FiniteStateMachine
@onready var animation_player = $AnimationPlayer

@onready var move_suvat = SUVAT.new(null, 0, 170, null, 1.0 / 60 * 31)

@export var pattern : Array[Direction]
var pattern_index = 0
var pattern_direction
var pattern_value
var pattern_finish = false

var velocity = Vector2.ZERO

func _ready():
	finite_state_machine.change_state("idle")
	
func _physics_process(delta):
	finite_state_machine.physics_process(delta)

func update_pattern():
	if pattern_index == pattern.size():
		pattern_finish = true
		return
	pattern_value = pattern[pattern_index]
	pattern_direction = _translate_direction(pattern_value)
	pattern_index += 1
	
func _translate_direction(direction):
	match direction:
		Direction.LEFT: return Vector2.LEFT
		Direction.RIGHT: return Vector2.RIGHT
		Direction.UP: return Vector2.UP
		Direction.DOWN: return Vector2.DOWN

func reset_pattern():
	pattern_index = 0
	pattern_finish = false
