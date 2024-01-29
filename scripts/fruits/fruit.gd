extends Area2D

@export_enum("apple", "bananas", "cherries", "kiwi", "melon", "orange", "pineapple", "strawberry") var type := "apple"
@onready var apple = preload("res://assets/fruits/apple.png")
@onready var bananas = preload("res://assets/fruits/bananas.png")
@onready var cherries = preload("res://assets/fruits/cherries.png")
@onready var kiwi = preload("res://assets/fruits/kiwi.png")
@onready var melon = preload("res://assets/fruits/melon.png")
@onready var orange = preload("res://assets/fruits/orange.png")
@onready var pineapple = preload("res://assets/fruits/pineapple.png")
@onready var strawberry = preload("res://assets/fruits/strawberry.png")
@onready var texture_map = {
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

var collected = false

func _ready():
	animation_player.play("idle")

func set_fruit_texture():
	sprite.texture = texture

func _on_body_entered(_body):
	collected = true
	animation_player.play("collect")
	collision_shape.set_deferred("disabled", true)
