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
	$SaveGameDialog.show()
	pass # replace with function body


func _on_LoadButton_button_down():
	$Control/LoadGameDialog.show()
	pass # replace with function body


func _on_OptionButton_button_down():
	pass # replace with function body


func _on_ExitButton_button_down():
	$Control/ConfirmationDialog.popup_centered()
	pass # replace with function body


func _on_ConfirmationDialog_confirmed():
	get_tree().quit() # exit game
