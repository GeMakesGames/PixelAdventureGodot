extends State
class_name PlayerBaseState

func gravity(delta, suvat = object.fall_suvat):
	object.velocity = object.velocity.move_toward(Vector2(object.velocity.x, suvat.v), suvat.a * delta)

func acceleration(delta, direction = object.input_manager.x):
	var current_direction = signi(object.velocity.x)
	var suvat = object.movement_suvat
	if finite_state_machine.current_state_name == "hit":
		suvat = object.hit_suvat
	elif direction == 0 or (current_direction != 0 and current_direction != direction):
		suvat = object.movement_stop_suvat
	object.velocity = object.velocity.move_toward(Vector2(object.movement_suvat.v * direction, object.velocity.y), suvat.a * delta)

func move_and_slide():
	object.move_and_slide()
	var current_platforms = []
	var has_terrain = false
	for i in object.get_slide_collision_count():
		var collision = object.get_slide_collision(i)
		var collider = collision.get_collider()
		var normal = collision.get_normal()
		if collider is FallingPlatform:
			if normal.y == -1:
				collider.step()
		elif collider is AnimatableBody2D and collider.get_parent() is BrownPlatform and normal.y == -1:
			var platform = collider.get_parent()
			current_platforms.append(platform)
			if not object.riding_platforms.has(platform):
				object.riding_platforms.append(platform)
				platform.has_riders = true
			
		if collider is Block:
			collider.destroy(object, normal)
		elif collider is Box and normal.y != 0:
			if normal.y == -1 and not finite_state_machine.current_state_name == "fall":
				continue
			collider.hit(object, normal.y)
		elif collider is TileMap and normal.y == -1 and not has_terrain:
			var body_rid = collision.get_collider_rid()
			var layer = collider.get_layer_for_body_rid(body_rid)
			var coord = collider.get_coords_for_body_rid(body_rid)
			var tile_data = collider.get_cell_tile_data(layer, coord)
			var terrain = tile_data.get_custom_data("terrain")
			if terrain:
				has_terrain = true
				if object.terrain != terrain:
					object.terrain = terrain
	if not has_terrain and object.terrain:
		object.terrain = null
	for platform in object.riding_platforms:
		if not current_platforms.has(platform):
			platform.has_riders = false
			object.riding_platforms.erase(platform)
	
func wall_check(distance = 1):
	for i in [-1, 1]:
		if object.test_move(object.get_transform(), Vector2(i, 0) * distance):
			return i
	return 0
