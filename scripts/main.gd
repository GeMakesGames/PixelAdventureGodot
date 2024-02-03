extends Node2D

@onready var transition = $TransitionLayer
@onready var hud = $HUDLayer

func _ready():
	Game.main = self
