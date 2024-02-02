extends Area2D

@onready var animation_player = $AnimationPlayer
@onready var finite_state_machine = $FiniteStateMachine
@onready var collision_shape = $CollisionShape2D
@onready var sprite = $Sprite2D

enum Direction {LEFT, RIGHT, UP, DOWN}

@export var direction := Direction.UP

var direction_vector

func _ready():
	sprite.rotation_degrees = _translate_direction_to_rotation(direction)
	direction_vector = _translate_direction_to_vector(direction)
	finite_state_machine.change_state("spawn")
	
func _physics_process(delta):
	finite_state_machine.physics_process(delta)

func _translate_direction_to_vector(direction_to_translate):
	match direction_to_translate:
		Direction.LEFT: return Vector2(-1, -.4)
		Direction.RIGHT: return Vector2(1, -.4)
		Direction.UP: return Vector2.UP
		Direction.DOWN: return Vector2.DOWN
		_: return Vector2.UP
		
func _translate_direction_to_rotation(direction_to_translate):
	match direction_to_translate:
		Direction.LEFT: return 270
		Direction.RIGHT: return 90
		Direction.DOWN: return 180
		_: return 0
		
func _on_body_entered(body):
	finite_state_machine.change_state("hit")
	body.launch(direction_vector * 400)
