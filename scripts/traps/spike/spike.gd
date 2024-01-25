extends Area2D

func _on_body_entered(body):
	body.hit_direction = (body.global_position - global_position).sign().x
	body.finite_state_machine.change_state("hit")
