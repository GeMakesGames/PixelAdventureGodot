extends Path2D

@onready var path_follow = $PathFollow2D
var chain_resource = preload("res://scripts/traps/platforms/platform_chain.tscn")

func _ready():
	for i in curve.point_count:
		var chain = chain_resource.instantiate()
		add_child(chain, false, Node.INTERNAL_MODE_FRONT)
		chain.position = curve.get_point_position(i)

func _physics_process(delta):
	path_follow.progress = path_follow.progress + delta * 20
