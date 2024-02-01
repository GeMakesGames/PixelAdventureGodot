extends StaticBody2D
class_name Block

@onready var animation_player = $AnimationPlayer
@onready var finite_state_machine = $FiniteStateMachine
@onready var collision_shape = $CollisionShape2D
@onready var sprite = $Sprite2D

var hit_direction
var player

func _ready():
	finite_state_machine.change_state("idle")

func _physics_process(delta):
	finite_state_machine.physics_process(delta)

func destroy(_player, _hit_direction):
	if finite_state_machine.current_state_name == "hit": return
	hit_direction = _hit_direction
	player = _player
	finite_state_machine.change_state("hit")
