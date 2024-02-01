extends AnimatableBody2D
class_name FallingPlatform

@onready var animation_player = $AnimationPlayer
@onready var finite_state_machine = $FiniteStateMachine
@onready var timer = $Timer
@onready var fall_suvat = SUVAT.new(null, 0, 250, null, 1.0 / 60 * 13)
@onready var particles = $GPUParticles2D
@onready var collision_shape = $CollisionShape2D
@onready var delay_timer = $DelayTimer

@export var delay := .1

var velocity = Vector2.ZERO
var original_position
var offset
var stepped = false

func _ready():
	delay_timer.wait_time = delay
	original_position = position
	offset = original_position + Vector2.DOWN * 10
	print(original_position)
	print(offset)
	finite_state_machine.change_state("on")
	delay_timer.start()
	
func _physics_process(delta):
	finite_state_machine.physics_process(delta)

func step():
	if stepped: return
	timer.start()
	stepped = true

func _on_timer_timeout():
	finite_state_machine.change_state("off")
