extends CanvasLayer

signal hidden
signal shown

var selection = 0

@onready var start_label = $SelectionContainer/VBoxContainer/StartLabel
@onready var controls_label = $SelectionContainer/VBoxContainer/ControlsLabel
@onready var credits_label = $SelectionContainer/VBoxContainer/CreditsLabel
@onready var quit_label = $SelectionContainer/VBoxContainer/QuitLabel
@onready var selection_indexes = [start_label, controls_label, credits_label, quit_label]



func _ready():
	set_process_input(false)
	_update_selection()

func hide_menu():
	Game.main.transition.fade_out()
	set_process_input(false)
	await Game.main.transition.finished
	hide()
	hidden.emit()

func show_menu():
	show()
	Game.main.transition.fade_in()
	await Game.main.transition.finished
	set_process_input(true)
	shown.emit()


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
