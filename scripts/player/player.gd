extends CharacterBody2D
class_name Player

signal died

@onready var input_manager = $InputManager
@onready var finite_state_machine = $FiniteStateMachine
@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var collision_shape = $CollisionShape2D

@onready var jump_suvat = SUVAT.new(48, null, 0, null, 1.0 / 60 * 15)
@onready var fall_suvat = SUVAT.new(null, 0, 160, null, 1.0 / 60 * 15)
@onready var run_suvat = SUVAT.new(null, 0, 110, null, 1.0 / 60 * 5)
@onready var stop_suvat = SUVAT.new(null, run_suvat.v, 0 , null, 1.0 / 60 * 3)
@onready var wall_slide_suvat = SUVAT.new(null, 0, 30, null, 1.0 / 60 * 30)
@onready var wall_slide_overspeed_suvat = SUVAT.new(null, fall_suvat.v, wall_slide_suvat.v, null, 1.0 / 60 * 10)
@onready var hit_suvat = SUVAT.new(null, 300, 1, null, 1.0 / 60 * 30)
@onready var hit_fall_suvat = SUVAT.new(null, -500, 320, null, 1.0 / 60 * 40)

#state related variables
var hit_direction
#end of state related variables

const WALL_JUMP_DISTANCE = 4

var can_double_jump = true

var facing_direction = 1:
	get:
		return facing_direction
	set(value):
		if value == 0: return
		sprite.flip_h = value == -1
		facing_direction = value

func _ready():
	finite_state_machine.change_state("idle")
	jump_suvat.v = fall_suvat.v # normalize the max fall speed
	
#func _process(_delta):
	#print("FPS: %d" % Engine.get_frames_per_second())

func land():
	can_double_jump = true

func _physics_process(delta):
	input_manager.update_input()
	finite_state_machine.physics_process(delta)

func update_facing_direction(direction = input_manager.x):
	facing_direction = direction


func _on_trap_area_body_entered(body):
	finite_state_machine.change_state("dead")
