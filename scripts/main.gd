extends Node2D

@onready var background = $ParallaxBackground
@onready var transition = $TransitionLayer
@onready var start_menu = $StartMenu
@onready var world = $World
@onready var hud = $HUDLayer
@onready var pause_background = $PauseBackground

func _ready():
	Game.main = self
	start_menu.show_menu()
