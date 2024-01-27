extends Path2D

@onready var finite_state_machine = $AnimatableBody2D/FiniteStateMachine
@onready var animation_player = $AnimatableBody2D/AnimationPlayer
@onready var path_follow = $PathFollow2D

var chain_resource = preload("res://scripts/traps/platforms/platform_chain.tscn")

var has_riders = false

func _ready():
	for i in curve.point_count:
		var chain = chain_resource.instantiate()
		add_child(chain, false, Node.INTERNAL_MODE_FRONT)
		chain.position = curve.get_point_position(i)
	finite_state_machine.change_state("off")

func _physics_process(delta):
	finite_state_machine.physics_process(delta)

func _on_player_area_body_entered(_body):
	has_riders = true

func _on_player_area_body_exited(_body):
	has_riders = false
