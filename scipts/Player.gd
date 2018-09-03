extends Node

onready var ship = get_node("ship_template")
onready var commander = get_node("player_commander")


func _ready():
	ship.set_commander(commander)
	ship.recalc_values()
	ship.position = Vector2(get_viewport().size.x / 2, get_viewport().size.y / 2)
	ship.rotate(PI/2)
	pass
	
func _process(delta):
	
	########### Input Handling  ###############
#	if Input.is_action_pressed("player_shoot"):
#		if gun_timer.time_left == 0:
#			shoot()
	handle_input(delta)
	
	#get_node("Camera2D").position = ship.position - Vector2(0,get_viewport().size.y/4).rotated(ship.rotation)
	



func handle_input(delta):
	if Input.is_action_pressed("player_left"):
		ship.rotate_left()
	if Input.is_action_pressed("player_right"):
		ship.rotate_right()
	if Input.is_action_pressed("player_thrust"):
		ship.thrust()
	#else:

