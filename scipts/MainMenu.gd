extends CanvasLayer

func _ready():
	$CenterContainer.margin_right = get_viewport().size.x
	$CenterContainer.margin_bottom = get_viewport().size.y
	$TitelContainer.margin_right = get_viewport().size.x
	$TitelContainer.margin_bottom = get_viewport().size.y / 8

	pass


func _on_ExitButton_button_down():
	get_tree().quit() # exit game
