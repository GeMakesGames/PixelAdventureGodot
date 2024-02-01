extends Node2D

@onready var upper = $UpperPart
@onready var bottom = $BottomPart

func _ready():
	$UpperPart.linear_velocity = Vector2(randf_range(25, 40) * (-1 if bool(randi_range(0,1)) else 1), -130)
	randomize()
	$BottomPart.linear_velocity = Vector2(randf_range(35, 50) * (-1 if bool(randi_range(0,1)) else 1), -20)
	$Timer.start()

func _on_timer_timeout():
	$BlinkTimer.start()

func _on_blink_timer_timeout():
	upper.visible = randi_range(0, 1) == 1
	bottom.visible = randi_range(0, 1) == 1
