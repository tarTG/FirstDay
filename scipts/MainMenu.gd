extends CanvasLayer

func _ready():
	$CenterContainer.margin_right = get_viewport().size.x
	$CenterContainer.margin_bottom = get_viewport().size.y
	$TitelContainer.margin_right = get_viewport().size.x
	$TitelContainer.margin_bottom = get_viewport().size.y / 8

	pass


func _on_ExitButton_button_down():
	get_tree().quit() # exit game


func _on_NewGameButton_button_down():
	Globals.goto_scene("res://scenes/CharacterGeneration.tscn")


func _on_LoadButton_button_down():
	$CenterContainer/LoadGameDialog.show()
	$CenterContainer/LoadGameDialog.invalidate()


func _on_OptionsButton_button_down():
	Globals.goto_scene("res://scenes/GameOptions.tscn")



func _on_LoadGameDialog_confirmed():
#	Globals.addPlayer()
	LoadSave.load_json($CenterContainer/LoadGameDialog.current_path)
	
