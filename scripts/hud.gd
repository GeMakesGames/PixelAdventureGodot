extends CanvasLayer

@onready var score_label = $MarginContainer/ScoreLabel

func _ready():
	_update_score_label()
	Game.score_changed.connect(_on_game_score_changed)

func _update_score_label():
	score_label.text = "score: %d" % Game.score

func _on_game_score_changed():
	_update_score_label()
