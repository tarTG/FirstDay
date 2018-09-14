extends Node

onready var ship = get_node("ship_template")
onready var commander = get_node("player_commander")
onready var inventory = $CharMenu.inventory_gui
onready var projectile = load("res://scenes/projectile.tscn")

func _ready():
	ship.set_commander(commander)
	ship.recalc_values()
	$HUD.set_bar_values(ship.ship_values)
	$CharMenu.hideMenu()
	pass
	
func _process(delta):
	
	########### Input Handling  ###############
#	if Input.is_action_pressed("player_shoot"):
#		if gun_timer.time_left == 0:
#			shoot()

	$HUD.set_bar_values(ship.ship_values)
	#get_node("Camera2D").position = ship.position - Vector2(0,get_viewport().size.y/4).rotated(ship.rotation)
	
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

	if event.is_action_pressed("char_menu"):
		if $CharMenu.visible == false:
			$CharMenu.showMenu()
			$CharMenu.setAttributes()
		else:
			$CharMenu.hideMenu()
	if event.is_action_pressed("shoot"):
		var p = projectile.instance()
		p.set_Color(Color(100,200,80))
		$bullets.add_child(p)
		p.fire($ship_template/Ship_components/CenterPos/ShipComponent/front_position.global_position,ship.global_rotation,500)
		
		
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
		"inventory":[]
		}
	for i in range (0,inventory.inventory_size):
		save_dict["inventory"].append(
			{  "slot" : inventory.item_list[i].slot_id,
			 "item_id" : inventory.item_list[i].item_id,
			"count" : inventory.item_list[i].count_num
			})
	
	return save_dict

func set(key, value):
	match key:
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
		#	$CharMenu.inventory_gui.inventory_size = commander.organisation * 2
		"comm_soci" : 
			commander.sociality = value
		"comm_respond": 
			commander.responsiveness = value
		"comm_att" :
			 commander.attention = value
		"inventory":
			$CharMenu.inventory_gui.load(value)
			
		_:
			print("Unknown load value " + key + " " + String(value))
	