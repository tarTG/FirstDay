extends RigidBody2D

onready var ship_values = get_node("ship_values")
onready var components = { "life_support":$life_support,
							"command_center" : $commpand_center,
							"engine" : $engine,
							"top_front" : $top_front_component,
							"top" : $top_component,
							"top_back" : $top_back_component,
							"bottom" : $bottom_component,
							"bottom_front": $bottom_front_component,
							"bottom_back" : $bottom_back_component}


var commander = null


export var thrust_multiplier = 10



func _ready():
	for i in components:
		components[i].disable()
	set_physics_process(true)
	
func set_commander(comm):
	commander = comm
	
	
func _physics_process(delta):
	pass

func _process(delta):
	ship_values.current_shield = min(ship_values.max_Shield, ship_values.current_shield + ship_values.shield_regen * delta)
	ship_values.current_hull = min(ship_values.max_Hull, ship_values.current_hull + ship_values.hull_regen * delta)
	
	

func thrust():
	apply_impulse(Vector2(0,0),Vector2(ship_values.thrust,0).rotated(rotation))


func rotate_left():
	angular_velocity = -ship_values.agillity 
	
func rotate_right():
	angular_velocity = ship_values.agillity

func remove_dir():
	angular_velocity = 0
	
func fire():
	if components["life_support"].component_stats.weapon_type != null:
		components["life_support"].fire()

func addComponent(values):
	components[values["component_type"]].load_component(values)
	


func load(values):
	for i in components:
		if values.has(i):
			components[i].load_component(values[i])

func save():
	var ret = {}
	for i in components:
		if components[i].component_stats.disabled == false:
			ret[i] = components[i].component_stats
	return ret

func recalc_values():
	ship_values.resetValues()
	
	for i in components:
		ship_values.max_Shield += components[i].component_stats.shield
		ship_values.max_Hull += components[i].component_stats.hull
		ship_values.max_Crew = components[i].component_stats.live_support + commander.sociality * 2
		ship_values.mass += components[i].component_stats.weight
		ship_values.thrust += components[i].component_stats.thrust
		ship_values.agillity += components[i].component_stats.position_control
		ship_values.sensor_thrength += components[i].component_stats.sensors
		ship_values.shield_regen  += components[i].component_stats.shield_regen
		ship_values.hull_regen += components[i].component_stats.hull_regen
		
	ship_values.mass += ship_values.current_crew * 0.07
	mass = ship_values.mass
	ship_values.thrust *= commander.boldness
	ship_values.agillity += commander.responsiveness
	ship_values.sensor_thrength += commander.attention
	ship_values.shield_regen += commander.improvisation
	ship_values.hull_regen += commander.improvisation