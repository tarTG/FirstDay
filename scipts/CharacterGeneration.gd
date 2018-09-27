extends HBoxContainer

onready var ShipSelection = $MarginContainer2/VBoxContainer2/HBoxContainer

var available_points = Globals.default_attribute_points 
var max_points = available_points +  7 * Globals.default_attribute_value
var selectedShip = 0
var commander = load("res://scenes/Commander.tscn").instance()


var start_ships = [null,null,null]

func _ready():	
	
	$MarginContainer/ComanderStats/VBoxContainer/PointRemain.text = String(available_points)
	var stat = get_tree().get_nodes_in_group("stats")
	for i in stat:
		i.connect("value_update",self, "Update_Stat")
		commander.setValue(i.label_name,i.current_val)
	
	for i in range(0,3):
		start_ships[i] = load("res://scenes/ship_template.tscn").instance()
		add_child(start_ships[i])
		for j in range (0,3): # add live suport, engine and command_center
			var component = ShipGeneration.generateShip(ShipGeneration.component_types.keys()[j],0)
			start_ships[i].addComponent(component)
			start_ships[i].components[ShipGeneration.component_types.keys()[j]].disabled = true
		start_ships[i].setCommander(commander)
		start_ships[i].setLight(false)
		start_ships[i].position = $MarginContainer2/VBoxContainer2/HBoxContainer.get_child(i).get_child(0).global_position
		start_ships[i].global_rotation = PI/2
		start_ships[i].recalc_values()
		print(String((start_ships[i].ship_values.max_Crew)))
	
func Update_Stat():
	calc_points()
	var stat = get_tree().get_nodes_in_group("stats")
	for i in stat:
		commander.setValue(i.label_name,i.current_val)
	start_ships[selectedShip].recalc_values()
	$MarginContainer2/VBoxContainer2/RichTextLabel.text = String(start_ships[selectedShip].ship_values.max_Crew)
	
func calc_points():
	var points = 0
	var stat = get_tree().get_nodes_in_group("stats")
	for i in stat:
		points += i.current_val
		commander.setValue(i.label_name,i.current_val)
		
	$MarginContainer/ComanderStats/VBoxContainer/PointRemain.text = String(max_points-points)
	if(max_points-points == 0):
		for i in stat:
			if(i.current_val != i.min_value):
				i.disableButton(false,true)
			else:
				i.disableButton(true,true)
		$MarginContainer2/VBoxContainer2/StartButton.disabled = false
	else:
		for i in stat:
			if(i.current_val != i.min_value):
				i.disableButton(false,false)
			else:
				i.disableButton(true,false)
		$MarginContainer2/VBoxContainer2/StartButton.disabled = true


func _on_StartButton_button_down():
	#Globals.player.player_commander = commander
#	Globals.player.ship = start_ships[selectedShip]
#	com.boldness = $MarginContainer/ComanderStats/Bold.current_val
#	com.thoroughness = $MarginContainer/ComanderStats/Through.current_val
#	com.improvisation = $MarginContainer/ComanderStats/Impro.current_val
#	com.organisation = $MarginContainer/ComanderStats/Orga.current_val
#	com.sociality = $MarginContainer/ComanderStats/Sozi.current_val
#	com.responsiveness = $MarginContainer/ComanderStats/Respon.current_val
#	com.attention = $MarginContainer/ComanderStats/Attention.current_val
#	com.commander_name = $MarginContainer/ComanderStats/NameContainer/TextEdit.text
	
	Globals.goto_scene("res://scenes/main.tscn")
	Globals.player.setCommAndShip(commander, start_ships[selectedShip])
	Globals.player.get_node("HUD").inventory.change_inventory_size(commander.organisation * 2)


func _on_Button_button_down():
	ButtonSelect(0)
	selectedShip = 0
	Update_Stat()
	pass # replace with function body


func _on_Button2_button_down():
	ButtonSelect(1)
	selectedShip = 1
	Update_Stat()
	pass # replace with function body


func _on_Button3_button_down():
	selectedShip = 2
	ButtonSelect(2)
	Update_Stat()
	pass # replace with function body

func ButtonSelect(index):
	for i in ShipSelection.get_child_count():
		if i == index:
			ShipSelection.get_child(i).pressed = true
		ShipSelection.get_child(i).pressed = false
