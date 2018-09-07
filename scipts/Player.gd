extends Node

onready var ship = get_node("ship_template")
onready var commander = get_node("player_commander")


func _ready():
	ship.set_commander(commander)
	ship.recalc_values()
	$HUD.set_bar_values(ship.ship_values)
	
	pass
	
func _process(delta):
	
	########### Input Handling  ###############
#	if Input.is_action_pressed("player_shoot"):
#		if gun_timer.time_left == 0:
#			shoot()

	$HUD.set_bar_values(ship.ship_values)
	#get_node("Camera2D").position = ship.position - Vector2(0,get_viewport().size.y/4).rotated(ship.rotation)
	if Input.is_action_pressed("player_left"):
		ship.rotate_left()
	if Input.is_action_pressed("player_right"):
		ship.rotate_right()
	if Input.is_action_pressed("player_thrust"):
		ship.thrust()



func _input(event):

	if event.is_action_pressed("char_menu"):
		if $CharMenu.visible == false:
			$CharMenu.showMenu()
		else:
			$CharMenu.hideMenu()


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
		}
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
		"comm_soci" : 
			commander.sociality = value
		"comm_respond": 
			commander.responsiveness = value
		"comm_att" :
			 commander.attention = value
		_:
			print("Unknown load value " + key + " " + String(value))