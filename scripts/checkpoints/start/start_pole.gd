extends StaticBody2D

@onready var sprite = $AnimatedSprite2D

func _on_player_area_body_entered(_body):
	sprite.play("moving")

func _on_player_area_body_exited(_body):
	sprite.play("idle")
