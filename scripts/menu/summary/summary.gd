extends CanvasLayer

func show_summary():
	$MarginContainer/GridContainer2/DeathCounter.text = ":%d" % Game.deaths
	$MarginContainer/GridContainer/AppleLabel.text = ":%d" % Game.fruits_collected["apple"]
	$MarginContainer/GridContainer/BananaLabel.text = ":%d" % Game.fruits_collected["bananas"]
	$MarginContainer/GridContainer/CherriesLabel.text = ":%d" % Game.fruits_collected["cherries"]
	$MarginContainer/GridContainer/KiwiLabel.text = ":%d" % Game.fruits_collected["kiwi"]
	$MarginContainer/GridContainer/MelonLabel.text = ":%d" % Game.fruits_collected["melon"]
	$MarginContainer/GridContainer/OrangeLabel.text = ":%d" % Game.fruits_collected["orange"]
	$MarginContainer/GridContainer/PineappleLabel.text = ":%d" % Game.fruits_collected["pineapple"]
	$MarginContainer/GridContainer/StrawberryLabel.text = ":%d" % Game.fruits_collected["strawberry"]
	var total_fruits = 0
	for f in Game.fruits_collected:
		total_fruits += Game.fruits_collected[f]
	$MarginContainer/GridContainer2/TotalFruits.text = ":%d" % total_fruits
	show()
	#TODO future me change from 3.0 to 10.0
	await get_tree().create_timer(10.0).timeout
	if visible:
		Game.main.transition.fade_out()
		await Game.main.transition.finished
		Game.main.world.unload_current_level()
		hide()
		Game.main.start_menu.show_menu()
