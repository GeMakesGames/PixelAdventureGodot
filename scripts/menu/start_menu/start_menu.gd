extends CanvasLayer

var selection = 0

@onready var start_label = $SelectionContainer/VBoxContainer/StartLabel
@onready var controls_label = $SelectionContainer/VBoxContainer/ControlsLabel
@onready var quit_label = $SelectionContainer/VBoxContainer/QuitLabel
@onready var selection_indexes = [start_label, controls_label, quit_label]

func _ready():
	_update_selection()

func hide_menu():
	hide()


func _input(event):
	if event.is_action_pressed("ui_down"):
		_increase_select(1)
	elif event.is_action_pressed("ui_up"):
		_increase_select(-1)
	elif event.is_action_pressed("ui_accept"):
		selection_indexes[selection].select()
		return
	_update_selection()
		
func _increase_select(i):
	selection = clampi(selection + i, 0, selection_indexes.size() - 1)

func _update_selection():
	for i in selection_indexes.size():
		selection_indexes[i].modulate.a = 1.0 if i == selection else .3
