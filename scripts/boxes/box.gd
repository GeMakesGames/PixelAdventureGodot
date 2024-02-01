extends StaticBody2D
class_name Box

@onready var collision_shape = $CollisionShape2D
@onready var destroy_timer = $DestroyTimer
@onready var sprite = $AnimatedSprite2D
@onready var rigid_fruit = preload("res://scripts/fruits/rigid_fruit.tscn")
@onready var top_spawn_point = $TopSpawnPoint
@onready var bottom_spawn_point = $BottomSpawnPoint

@export var upward_speed := -160
@export var downward_speed := 160
@export var hp := 5
@export var fragments : PackedScene

var is_hit = false

func _ready():
	sprite.play("idle") 

func _physics_process(_delta):
	if not is_hit: return
	if not sprite.is_playing():
		is_hit = false
		if hp <= 0:
			destroy()
		else:
			sprite.play("idle")

func hit(player, direction):
	if is_hit or hp <= 0: return
	player.velocity.y = downward_speed if direction == 1 else upward_speed
	player.finite_state_machine.change_state("launch")
	is_hit = true
	sprite.play("hit")
	hp -= 1
	spawn_fruit(direction)

func destroy():
	sprite.play("destroy")
	collision_shape.set_deferred("disabled", true)
	destroy_timer.start()
	spawn_fragments()
	
func spawn_fragments():
	var f = fragments.instantiate()
	add_child(f)
	
func spawn_fruit(direction):
	var fruit = rigid_fruit.instantiate()
	randomize()
	fruit.linear_velocity = Vector2(randf_range(25, 40) * (-1 if bool(randi_range(0,1)) else 1), randf_range(-400, -200) if direction == 1 else 0)
	fruit.global_position = top_spawn_point.global_position if direction == 1 else bottom_spawn_point.global_position
	add_sibling(fruit)

func _on_destroy_timer_timeout():
	queue_free()
