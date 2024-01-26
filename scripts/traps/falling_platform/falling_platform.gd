extends AnimatableBody2D

@onready var animation_player = $AnimationPlayer
@onready var finite_state_machine = $FiniteStateMachine
@onready var timer = $Timer
@onready var fall_suvat = SUVAT.new(null, 0, 160, null, 1.0 / 60 * 30)

var velocity = Vector2.ZERO

func _ready():
	finite_state_machine.change_state("on")
	
func _physics_process(delta):
	finite_state_machine.physics_process(delta)

func _on_step_area_body_entered(body):
	timer.start()

func _on_timer_timeout():
	finite_state_machine.change_state("off")
