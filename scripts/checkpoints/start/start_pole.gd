extends StaticBody2D

@export var active := true :
	get: return active
	set(value):
		active = value
		if value:
			activated.emit(self)
			
@onready var sprite = $AnimatedSprite2D

signal activated

func _on_player_area_body_entered(_body):
	sprite.play("moving")

func _on_player_area_body_exited(_body):
	sprite.play("idle")

func get_spawn_position():
	return global_position + Vector2(8, -8)
