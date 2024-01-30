extends Node2D

@onready var top_left_body = $TopLeft
@onready var top_right_body = $TopRight
@onready var bottom_left_body = $BottomLeft
@onready var bottom_right_body = $BottomRight
@onready var blink_timer = $BlinkTimer

func _ready():
	$Timer.start()
	top_left_body.linear_velocity = Vector2(randf_range(-30, -70), randf_range(-30, -70))
	top_right_body.linear_velocity = Vector2(randf_range(30, 70), randf_range(-30, -70))
	bottom_left_body.linear_velocity = Vector2(randf_range(-30, -70), 0)
	bottom_right_body.linear_velocity = Vector2(randf_range(30, 70),  0)


func _on_timer_timeout():
	blink_timer.start()

func _on_blink_timer_timeout():
	top_left_body.visible = randi_range(0, 1) == 1
	top_right_body.visible = randi_range(0, 1) == 1
	bottom_left_body.visible = randi_range(0, 1) == 1
	bottom_right_body.visible = randi_range(0, 1) == 1
