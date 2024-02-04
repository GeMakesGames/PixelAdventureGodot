extends Sprite2D

@export var speed : int
@onready var resource_preloader = $BackgroundResources

var initial_position
var w
var h

func _ready():
	var list = resource_preloader.get_resource_list()
	texture = resource_preloader.get_resource(list[randi() % list.size()])
	initial_position = position
	w = texture.get_width()
	h = texture.get_height()
	region_rect = region_rect.grow_side(SIDE_LEFT, w)
	region_rect = region_rect.grow_side(SIDE_RIGHT, w)
	region_rect = region_rect.grow_side(SIDE_BOTTOM, h)
	region_rect = region_rect.grow_side(SIDE_TOP, h)

func _process(delta):
	position.x += speed * delta
	position.x = fmod(position.x + initial_position.x, w) + initial_position.x
