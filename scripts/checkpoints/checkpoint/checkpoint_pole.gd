extends Area2D

signal activated

@onready var sprite = $AnimatedSprite2D

var active:
	get:
		return active
	set(value):
		if value == active: return
		active = value
		if value:
			sprite.play("flag_out")
			deploying = true
			disable = false
			activated.emit(self)
		else:
			sprite.play("flag_in")
			disable = true
			deploying = false

var deploying = false
var disable = false

func _process(_delta):
	if not deploying and not disable: return
	if deploying and not sprite.is_playing():
		sprite.play("flag_idle")
		deploying = false
	elif disable and not sprite.is_playing():
		sprite.play("no_flag")
		disable = false


func _on_body_entered(_body):
	active = true

func get_spawn_position():
	return global_position
