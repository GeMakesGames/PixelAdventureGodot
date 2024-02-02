extends StaticBody2D
class_name Trampoline

@onready var finite_state_machine = $FiniteStateMachine
@onready var animation_player = $AnimationPlayer
@onready var collision_shape = $CollisionShape2D

var player

func _ready():
	finite_state_machine.change_state("idle")

func _physics_process(delta):
	finite_state_machine.physics_process(delta)

func activate(_player):
	player = _player
	finite_state_machine.change_state("jump")
