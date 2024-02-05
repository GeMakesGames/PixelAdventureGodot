extends Node2D

var active_checkpoint

func _ready():
	for child in get_children():
		if child.has_signal("activated"):
			child.activated.connect(_on_checkpoint_activated)
			if child.active:
				active_checkpoint = child
			
func _on_checkpoint_activated(checkpoint):
	if active_checkpoint:
		active_checkpoint.active = false
	active_checkpoint = checkpoint
