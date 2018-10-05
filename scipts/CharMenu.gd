extends MarginContainer

onready var inventory_gui = $CanvasLayer/Container/Stats_Container/VBoxContainer/inventory_system
onready var player = Globals.player
onready var ShipStats = $CanvasLayer/Container/ShipStatsGui


func _ready():
	var stat = get_tree().get_nodes_in_group("stats")

	for i in stat:
		i.connect("value_update",self, "Update_Stat")
		
#	inventory_gui.inventory_size = player.commander.organisation * 2
	inventory_gui.inventory_columns = 5
	inventory_gui.init()
	

func init():
	ShipStats.generate(player.ship.ship_values.getAsDictionary())
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

func setName(name):
	$CanvasLayer/Container/Stats_Container/ComanderStats/NameContainer/TextEdit.text = player.commander.commander_name
	$CanvasLayer/Container/Stats_Container/ComanderStats/NameContainer/TextEdit.editable = false
	
func setAttributes():
	for i in get_tree().get_nodes_in_group("stats"):
		i.current_val = player.commander.getValue(i.label_name)
		i.display_val()
	player.ship.recalc_values()
	ShipStats.updateStats(player.ship.ship_values.getAsDictionary())

func Update_Stat():
	for i in get_tree().get_nodes_in_group("stats"):
		player.commander.setValue(i.label_name,i.current_val)

	inventory_gui.change_inventory_size(player.commander.organisation * 2)
	player.ship.recalc_values()
	ShipStats.updateStats(player.ship.ship_values.getAsDictionary())
	
func _on_ExitButton_button_down():
	hideMenu()
	Globals.pause = false
	get_tree().paused = Globals.pause
	pass # replace with function body




