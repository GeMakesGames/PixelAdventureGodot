extends Node2D

@export_group("Lenght and Chain Settings")
@export var lenght := 4
@export var distance_between_chains := 8

@export_group("Path Settings")
@export var curve : Curve
@export var duration := 5.0
var elapsed = 0

@onready var damage_area = $DamageArea


@onready var spike_chain_resource = preload("res://scripts/traps/spike_ball/spike_chain.tscn")

func _ready():
	damage_area.position = Vector2(0, (lenght - 1) * distance_between_chains)
	for i in lenght:
		var chain = spike_chain_resource.instantiate()
		add_child(chain, false, Node.INTERNAL_MODE_FRONT)
		chain.position = Vector2(0, i * distance_between_chains)

func _physics_process(delta):
	elapsed += delta
	if elapsed > duration:
		elapsed = fmod(elapsed, duration)
	rotation_degrees = curve.sample(elapsed / duration)

func _on_damage_area_body_entered(body):
	body.hit_direction = (body.global_position - damage_area.global_position).sign().x
	body.finite_state_machine.change_state("hit")

