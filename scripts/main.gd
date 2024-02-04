extends Node2D

@onready var background = $ParallaxBackground
@onready var transition = $TransitionLayer
@onready var start_menu = $StartMenu
@onready var hud = $HUDLayer

func _ready():
	Game.main = self
	transition.fade_in()
