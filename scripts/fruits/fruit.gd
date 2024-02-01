extends Area2D
class_name Fruit

@export_enum("apple", "bananas", "cherries", "kiwi", "melon", "orange", "pineapple", "strawberry") var type := "apple"
const apple = preload("res://assets/fruits/apple.png")
const bananas = preload("res://assets/fruits/bananas.png")
const cherries = preload("res://assets/fruits/cherries.png")
const kiwi = preload("res://assets/fruits/kiwi.png")
const melon = preload("res://assets/fruits/melon.png")
const orange = preload("res://assets/fruits/orange.png")
const pineapple = preload("res://assets/fruits/pineapple.png")
const strawberry = preload("res://assets/fruits/strawberry.png")
const texture_map = {
	"apple" : apple,
	"bananas" : bananas,
	"cherries" : cherries,
	"kiwi" : kiwi,
	"melon" : melon,
	"orange" : orange,
	"pineapple" : pineapple,
	"strawberry" : strawberry
}
@onready var texture = texture_map[type]

@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var collision_shape = $CollisionShape2D

@export var random := false :
	get:
		return random
	set(value):
		random = value
		if value:
			type = texture_map.keys()[randi_range(0, texture_map.keys().size() - 1)]

var collected = false

func _ready():
	if random:
		type = texture_map.keys()[randi_range(0, texture_map.keys().size() - 1)]
	animation_player.play("idle")

func set_fruit_texture():
	sprite.texture = texture

func _on_body_entered(_body):
	collected = true
	animation_player.play("collect")
	collision_shape.set_deferred("disabled", true)
