extends ParallaxBackground

@onready var parallax_layer = $ParallaxLayer
@onready var sprite = $ParallaxLayer/Sprite2D

func _ready():
	randomize_background()

func _process(delta):
	parallax_layer.motion_offset.x += delta * 64
	
func randomize_background():
	var list = $BackgroundResources.get_resource_list()
	sprite.texture = $BackgroundResources.get_resource(list[randi() % list.size()])
