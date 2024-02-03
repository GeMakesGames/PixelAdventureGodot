extends ParallaxBackground

func _process(delta):
	$ParallaxLayer.motion_offset.x += delta * 64
