extends CanvasLayer

func _ready():
	pass


func _on_ResumeButten_button_down():
	Globals.pause = not Globals.pause
	get_tree().paused = Globals.pause
	$Control.hide()
	queue_free()
	pass # replace with function body


func _on_SaveButton_button_down():
	$CenterContainer/SaveGameDialog.show()
	$CenterContainer/SaveGameDialog.invalidate()
	pass # replace with function body


func _on_LoadButton_button_down():
	$CenterContainer/LoadGameDialog.show()
	$CenterContainer/LoadGameDialog.invalidate()
	pass # replace with function body


func _on_OptionButton_button_down():
	pass # replace with function body


func _on_ExitButton_button_down():
	$Control/ConfirmationDialog.popup_centered()
	pass # replace with function body


func _on_ConfirmationDialog_confirmed():
	get_tree().quit() # exit game


func _on_SaveGameDialog_confirmed():
	LoadSave.saveGame($CenterContainer/SaveGameDialog.current_path)
	pass # replace with function body


func _on_LoadGameDialog_confirmed():#
	Globals.pause = not Globals.pause
	get_tree().paused = Globals.pause
	$Control.hide()
	queue_free()
	LoadSave.load_json($CenterContainer/LoadGameDialog.current_path)
	