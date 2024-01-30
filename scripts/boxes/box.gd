extends StaticBody2D
class_name Box

@onready var collision_shape = $CollisionShape2D
@onready var destroy_timer = $DestroyTimer
@onready var sprite = $AnimatedSprite2D

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
	is_hit = true
	sprite.play("hit")
	hp -= 1
	spawn_fruit()

func destroy():
	sprite.play("destroy")
	collision_shape.set_deferred("disabled", true)
	destroy_timer.start()
	spawn_fragments()
	
func spawn_fragments():
	var f = fragments.instantiate()
	add_child(f)
	
func spawn_fruit():
	print("Spawning Fruit")

func _on_destroy_timer_timeout():
	queue_free()
