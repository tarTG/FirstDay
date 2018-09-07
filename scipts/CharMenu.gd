extends MarginContainer

onready var inventory_gui = $CanvasLayer/Container/Stats_Container/VBoxContainer/ItemList

var inventory = {}
var inventory_maxSlots = 40



func _ready():
	hideMenu()
	inventory_gui.max_columns = 9
	inventory_gui.fixed_icon_size = Vector2(48,48)
	inventory_gui.icon_mode = ItemList.ICON_MODE_TOP
	inventory_gui.select_mode = ItemList.SELECT_SINGLE
	inventory_gui.same_column_width = true
	
	for slot in range(0,inventory_maxSlots):
		inventory[String(slot)] = {"id":"0", "amount":0}
	pass

func _process(delta):
	#if visible:
	#	if Input.is_action_pressed("char_menu"):
		#	hideMenu()
	pass

func hideMenu():
	self.hide()
	$CanvasLayer/Container.hide()
	$CanvasLayer/ColorRect.hide()
#	visible = false

func showMenu():
	self.show()
	$CanvasLayer/Container.show()
	$CanvasLayer/ColorRect.show()
#	visible = true

func _on_ExitButton_button_down():
	hideMenu()
	pass # replace with function body



