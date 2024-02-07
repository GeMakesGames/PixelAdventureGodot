extends Area2D
class_name Fruit

@export_enum("apple", "bananas", "cherries", "kiwi", "melon", "orange", "pineapple", "strawberry") var type := "apple"

@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var collision_shape = $CollisionShape2D
@onready var resource_loader = $ResourcePreloader

@export var random := false

var collected = false

func _ready():
	if random:
		var list = resource_loader.get_resource_list()
		type = list[randi() % list.size()]
	animation_player.play("idle")

func set_fruit_texture():
	sprite.texture = resource_loader.get_resource(type)

func _on_body_entered(_body):
	collected = true
	animation_player.play("collect")
	collision_shape.set_deferred("disabled", true)
	Game.fruits_collected[type] += 1
