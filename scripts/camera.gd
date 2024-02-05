extends Camera2D

func _ready():
	Game.camera = self
	reset_smoothing()
