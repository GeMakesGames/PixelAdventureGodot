extends State

const fragments = preload("res://scripts/traps/blocks/block_fragment.tscn")

var destroy

func enter():
	object.animation_player.play("top" if object.hit_direction.y != 0 else "side")
	object.player.launch(object.player.velocity + object.hit_direction * Vector2(400, 200))

func physics_process(_delta):
	if not object.animation_player.is_playing() and not destroy:
		destroy = true
		object.sprite.visible = false
		object.collision_shape.set_deferred("disabled", true)
		var fragment = fragments.instantiate()
		$DestroyTimer.start()
		object.add_child(fragment)

func _on_destroy_timer_timeout():
	object.queue_free()
