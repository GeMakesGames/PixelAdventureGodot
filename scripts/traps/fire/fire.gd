extends StaticBody2D

@onready var finite_state_machine = $FiniteStateMachine
@onready var animation_player = $AnimationPlayer
@onready var step_area = $StepArea
@onready var fire_area_collision_shape = $FireArea/CollisionShape2D

func _ready():
	finite_state_machine.change_state("off")

func _physics_process(delta):
	finite_state_machine.physics_process(delta)

func _on_step_area_body_entered(_body):
	if finite_state_machine.current_state_name == "off":
		finite_state_machine.change_state("hit")

func _on_fire_area_body_entered(body):
	body.hit_direction = (body.global_position - global_position).sign().x
	body.finite_state_machine.change_state("hit")
