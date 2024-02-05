extends CharacterBody2D
class_name Player

signal died
signal disappeared
signal spawned

@onready var resource_preloader = $ResourcePreloader
@onready var input_manager = $InputManager
@onready var finite_state_machine = $FiniteStateMachine
@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var collision_shape = $CollisionShape2D
@onready var squish_collision_shape = $SquishArea/CollisionShape2D

@onready var jump_suvat = SUVAT.new(48, null, 0, null, 1.0 / 60 * 15)
@onready var fall_suvat = SUVAT.new(null, 0, 160, null, 1.0 / 60 * 15)
@onready var wall_slide_suvat = SUVAT.new(null, 0, 30, null, 1.0 / 60 * 30)
@onready var wall_slide_overspeed_suvat = SUVAT.new(null, fall_suvat.v, wall_slide_suvat.v, null, 1.0 / 60 * 10)
@onready var hit_suvat = SUVAT.new(null, 300, 1, null, 1.0 / 60 * 30)
@onready var hit_fall_suvat = SUVAT.new(null, -500, 320, null, 1.0 / 60 * 40)

@onready var run_suvat = SUVAT.new(null, 0, 110, null, 1.0 / 60 * 5)
@onready var stop_suvat = SUVAT.new(null, run_suvat.v, 0 , null, 1.0 / 60 * 3)
@onready var sand_suvat = SUVAT.new(null, 0, 55, null, 1.0 / 60 * 5)
@onready var ice_run_suvat = SUVAT.new(null, 0, 150, null, 1.0)
@onready var ice_stop_suvat = SUVAT.new(null, ice_run_suvat.v, 0 , null, 1.5)
@onready var mud_run_suvat = SUVAT.new(null, 0, 0, 9000, null)
@onready var mud_stop_suvat = SUVAT.new(null, 0, 0 , 9000, null)

@onready var movement_suvat = run_suvat
@onready var movement_stop_suvat = stop_suvat

var current_terrain_particle_texture = dust_particle_texture

@onready var slide_particle_container = $SlideParticleContainer
@onready var jump_particle_container = $JumpParticleContainer
@onready var wall_jump_particle_container = $WallJumpParticleContainer
@onready var wall_jump_particle_sub_container = $WallJumpParticleContainer/SubContainer
@onready var run_particle = $RunParticle
@onready var slide_particle = $SlideParticleContainer/SlideParticle
@onready var launch_particle_position = $LaunchParticlePosition

@onready var wall_jump_particle_resource = preload("res://scripts/player/wall_jump_particle.tscn")
@onready var jump_particle_resource = preload("res://scripts/player/jump_particle.tscn")
@onready var launch_particle_resource = preload("res://scripts/player/launch_particle.tscn")
@onready var ice_particle_texture = preload("res://assets/traps/terrain/ice-particle.png")
@onready var mud_particle_texture = preload("res://assets/traps/terrain/mud-particle.png")
@onready var sand_particle_texture = preload("res://assets/traps/terrain/sand-particle.png")
@onready var dust_particle_texture = preload("res://assets/others/dust_particle.png")

@onready var available_characters = ["virtual-guy", "pinkman", "ninja-frog", "mask-dude"]
var character = "pinkman"

#state related variables
var hit_direction
var launch_velocity
#end of state related variables

var riding_platforms = []

const WALL_JUMP_DISTANCE = 4

var can_double_jump = true

var facing_direction = 1:
	get:
		return facing_direction
	set(value):
		if value == 0: return
		sprite.flip_h = value == -1
		run_particle.scale.x = value
		slide_particle_container.scale.x = value
		facing_direction = value
		wall_jump_particle_container.scale.x = value

var terrain :
	get:
		return terrain
	set(value):
		terrain = value
		match value:
			"sand":
				movement_suvat = sand_suvat
				movement_stop_suvat = stop_suvat
				run_particle.texture = sand_particle_texture
				current_terrain_particle_texture = sand_particle_texture
			"ice":
				movement_suvat = ice_run_suvat
				movement_stop_suvat = ice_stop_suvat
				run_particle.texture = ice_particle_texture
				current_terrain_particle_texture = ice_particle_texture
			"mud":
				movement_suvat = mud_run_suvat
				movement_stop_suvat = mud_stop_suvat
				run_particle.texture = mud_particle_texture
				current_terrain_particle_texture = mud_particle_texture
			_:
				movement_suvat = run_suvat
				movement_stop_suvat = stop_suvat
				run_particle.texture = dust_particle_texture
				current_terrain_particle_texture = dust_particle_texture

func _ready():
	Game.player = self
	randomize_character()
	terrain = ""
	jump_suvat.v = fall_suvat.v # normalize the max fall speed

func randomize_character():
	character = available_characters[randi() % available_characters.size()]
#func _process(_delta):
	#print("FPS: %d" % Engine.get_frames_per_second())

func land():
	can_double_jump = true

func _physics_process(delta):
	input_manager.update_input()
	finite_state_machine.physics_process(delta)

func update_facing_direction(direction = input_manager.x):
	facing_direction = direction


func _on_trap_area_body_entered(_body):
	finite_state_machine.change_state("dead")

func emit_launch_particles():
	var particle = launch_particle_resource.instantiate()
	launch_particle_position.add_child(particle)
	particle.amount = min((1.0/500) * abs(launch_velocity.y), 2) * particle.amount
	particle.emitting = true
	particle.connect("finished", func(): particle.queue_free())

func _emit_jump_particles(container, particle_resource, texture = current_terrain_particle_texture):
	var particle = particle_resource.instantiate()
	container.add_child(particle)
	particle.texture = texture
	particle.emitting = true
	particle.connect("finished", func(): particle.queue_free())

func emit_jump_particles():
	_emit_jump_particles(jump_particle_container, jump_particle_resource)
	
func emit_wall_jump_particles():
	_emit_jump_particles(wall_jump_particle_sub_container, wall_jump_particle_resource, dust_particle_texture)
	
func _on_squish_area_body_entered(_body):
	hit_direction = -1
	finite_state_machine.change_state("hit")

func launch(_velocity):
	launch_velocity = _velocity
	finite_state_machine.change_state("launch")

func set_animation_texture(suffix):
	sprite.texture = resource_preloader.get_resource("%s-%s" % [character, suffix])
