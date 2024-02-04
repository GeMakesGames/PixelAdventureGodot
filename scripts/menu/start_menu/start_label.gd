extends Label

func select():
	Game.main.transition.fade_out()
	await Game.main.transition.finished
	Game.main.start_menu.hide_menu()
	Game.main.transition.fade_in()
