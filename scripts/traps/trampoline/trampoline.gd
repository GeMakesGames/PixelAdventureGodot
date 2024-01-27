extends Area2D

@onready var finite_state_machine = $FiniteStateMachine
@onready var animation_player = $AnimationPlayer

var player

func _ready():
	finite_state_machine.change_state("idle")

func _on_body_entered(body):
	player = body
	finite_state_machine.change_state("jump")

func _on_body_exited(_body):
	player = null
