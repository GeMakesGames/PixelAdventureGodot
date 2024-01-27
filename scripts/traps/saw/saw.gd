extends Path2D

@onready var path_follow = $PathFollow2D
@onready var damage_area = $DamageArea
@export var speed_curve : Curve
@export var constant_acceleration := 150.0
@export var has_chains := true

var chain_resource = preload("res://scripts/traps/saw/saw_chain.tscn")

func _ready():
	if has_chains:
		for i in curve.point_count:
			var chain = chain_resource.instantiate()
			add_child(chain, false, Node.INTERNAL_MODE_FRONT)
			chain.position = curve.get_point_position(i)

func _physics_process(delta):
	var speed = constant_acceleration if not speed_curve else speed_curve.sample(path_follow.progress_ratio)
	path_follow.progress = path_follow.progress + speed * delta

func _on_damage_area_body_entered(body):
	body.hit_direction = (body.global_position - damage_area.global_position).sign().x
	body.finite_state_machine.change_state("hit")

