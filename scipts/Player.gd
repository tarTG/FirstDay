extends Node

onready var ship = get_node("ship_template")
var commander# = get_node("player_commander")

onready var hud = $HUD

func _ready():
#	ship.setCommander(commander)
#	ship.recalc_values()
	ship.add_to_group("Player")
#	hud.set_bar_values(ship.ship_values)
	$HUD/CharMenu.init()
	pass
	
func setCommAndShip(_comm, _ship):
#	remove_child(commander)
	add_child(_comm)
	commander = get_node("Commander")
	ship.load(_ship.save())
	
	ship.setCommander(commander)
	$HUD/CharMenu.setAttributes()
	ship.recalc_values()

	hud.set_bar_values(ship.ship_values)
	$HUD/CharMenu.setName(commander.commander_name)
	
	
func _process(delta):
	
	########### Input Handling  ###############

	hud.set_bar_values(ship.ship_values)

	var mouse_vec = (get_viewport().get_mouse_position() -get_viewport().size/2).normalized()
	var top_vec = ((Vector2(0,1) + get_viewport().size/2) -get_viewport().size/2).rotated(ship.rotation- PI/2).normalized()
	var deg = top_vec.angle_to(mouse_vec)
#
	if (deg < -0.1 or deg > 0.1 ) :
		if(deg < 0 ):	
			ship.rotate_left()
		else :
			ship.rotate_right()
	else:
		ship.remove_dir()

	if Input.is_action_pressed("player_thrust"):
		ship.thrust()



func _input(event):
	if event.is_action_pressed("shoot"):
		ship.fire()

		
func save():
	var save_dict = {
        "level" : Globals.current_scene_path,
        "pos_x" : ship.position.x, # Vector2 is not supported by JSON
        "pos_y" : ship.position.y,
        "current_shield" : ship.ship_values.current_shield,
        "current_hull" : ship.ship_values.current_hull,
        "current_crew" : ship.ship_values.current_crew,		
		"comm_name" : commander.commander_name,
		"comm_bold" : commander.boldness,
		"comm_thorou": commander.thoroughness,
		"comm_impro" : commander.improvisation,
		"comm_orga" : commander.organisation,
		"comm_soci" : commander.sociality,
		"comm_respond": commander.responsiveness,
		"comm_att" : commander.attention,
		"parent" : get_parent().get_path(),
		"components": ship.save(),
		"inventory":[]		
		}
	for i in range (0,$HUD.inventory.inventory_size):
		save_dict["inventory"].push_back(
			{  "slot" : hud.inventory.item_list[i].slot_id,
			 	"item_id" : hud.inventory.item_list[i].item_id,
				"count" : hud.inventory.item_list[i].count_num
			})
	
	return save_dict

func set(dict):

	add_child(load("res://scenes/Commander.tscn").instance())
	commander = get_node("Commander")
	ship.setCommander(commander)
	hud.set_bar_values(ship.ship_values)
	$HUD/CharMenu.setName(commander.commander_name)
	for i in dict.keys():
		var value = dict[i]
		match i:
			"pos_x" : 
				ship.position.x = value
			"pos_y" : 
				ship.position.y = value
			"current_shield" : 
				ship.ship_values.current_shield = value
			"current_hull" : 
				ship.ship_values.current_hull = value
			"current_crew" : 
				ship.ship_values.current_crew= value
			"comm_name" : 
				commander.commander_name = value
			"comm_bold" :  
				commander.boldness = value
			"comm_thorou": 
				commander.thoroughness = value
			"comm_impro" : 
				commander.improvisation = value
			"comm_orga" : 
				commander.organisation = value
			"comm_soci" : 
				commander.sociality = value
			"comm_respond": 
				commander.responsiveness = value
			"comm_att" :
				 commander.attention = value
			"inventory":
				$HUD.inventory.load(value)
			"components":
				ship.load(value)
				
			_:
				print("Unknown load value " + i + " " + String(value))
	$HUD/CharMenu.setAttributes()
	ship.recalc_values()		
	$HUD/CharMenu.Update_Stat()
	$HUD/CharMenu.setName(commander.commander_name)
	