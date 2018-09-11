extends MarginContainer

onready var inventory_gui = $CanvasLayer/Container/Stats_Container/VBoxContainer/inventory_system


var emptySlot = {"id":"0", "amount":0}

func _ready():
	#hideMenu()
	inventory_gui.inventory_size = 20
	inventory_gui.inventory_columns = 5
	inventory_gui.init([1,1])


func _process(delta):

	pass

func hideMenu():
	self.hide()
	$CanvasLayer/Container.hide()
	$CanvasLayer/ColorRect.hide()


func showMenu():
	self.show()
	$CanvasLayer/Container.show()
	$CanvasLayer/ColorRect.show()


	
func _on_ExitButton_button_down():
	hideMenu()
	pass # replace with function body




