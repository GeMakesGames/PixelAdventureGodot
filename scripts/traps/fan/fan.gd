extends Area2D

@onready var finite_state_machine = $FiniteStateMachine
@onready var animation_player = $AnimationPlayer
@onready var particles = $GPUParticles2D

@export_category("Timers")
@export var start_time : float
@export var cd_time : float
@export var duration_time : float

var player

func _ready():
	$StartTimer.wait_time = start_time
	$FiniteStateMachine/Off/CooldownTimer.wait_time = cd_time
	$FiniteStateMachine/On/DurationTimer.wait_time = duration_time
	$StartTimer.start()

func _physics_process(delta):
	finite_state_machine.physics_process(delta)

func _on_start_timer_timeout():
	finite_state_machine.change_state("on")

func _on_body_entered(body):
	player = body

func _on_body_exited(_body):
	player = null
