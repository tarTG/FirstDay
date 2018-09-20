extends HBoxContainer


var available_points = Globals.default_attribute_points 
var max_points = available_points +  7 * Globals.default_attribute_value

var start_ships = []

func _ready():	
	$MarginContainer/ComanderStats/VBoxContainer/PointRemain.text = String(available_points)
	var stat = get_tree().get_nodes_in_group("stats")
	for i in stat:
		i.connect("value_update",self, "Update_Stat")
	
	for i in range(0,1):
		var ship = load("res://scenes/ship_template.tscn").instance()
		add_child(ship)
		for i in range (0,4): # add live suport, engine and command_center
			ship.addComponent(ShipGeneration.generateShip(ShipGeneration.component_types.keys()[i],0))
		ship.position = $MarginContainer2/VBoxContainer2/HBoxContainer/Button/Position2D.global_position
		#start_ships[i] = 
		#$MarginContainer2/VBoxContainer2/HBoxContainer/Button3.icon(ship.
func Update_Stat():
	calc_points()
	
	
func calc_points():
	var points = 0
	var stat = get_tree().get_nodes_in_group("stats")
	for i in stat:
		points += i.current_val
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
	var com = Globals.player.get_node("player_commander")
	com.boldness = $MarginContainer/ComanderStats/Bold.current_val
	com.thoroughness = $MarginContainer/ComanderStats/Through.current_val
	com.improvisation = $MarginContainer/ComanderStats/Impro.current_val
	com.organisation = $MarginContainer/ComanderStats/Orga.current_val
	com.sociality = $MarginContainer/ComanderStats/Sozi.current_val
	com.responsiveness = $MarginContainer/ComanderStats/Respon.current_val
	com.attention = $MarginContainer/ComanderStats/Attention.current_val
	com.commander_name = $MarginContainer/ComanderStats/NameContainer/TextEdit.text
	Globals.goto_scene("res://scenes/main.tscn")
	Globals.player.get_node("HUD").inventory.change_inventory_size(com.organisation * 2)
