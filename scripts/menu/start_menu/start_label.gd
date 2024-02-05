extends Label

func select():
	Game.main.start_menu.hide_menu()
	await Game.main.start_menu.hidden
	Game.main.world.load_level("level_1")
