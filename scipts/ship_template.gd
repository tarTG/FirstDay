extends RigidBody2D

onready var ship_values = get_node("ship_values")

var commander = null


export var thrust_multiplier = 10

var current_pos = Vector2()
var current_rot = 0
var vel = Vector2()
var acc = Vector2()

func _ready():
	set_physics_process(true)
	
func set_commander(comm):
	commander = comm
	
	
func _physics_process(delta):
	pass

func _process(delta):
	ship_values.current_shield = min(ship_values.max_Shield, ship_values.current_shield + ship_values.shield_regen * delta)
	ship_values.current_hull = min(ship_values.max_Hull, ship_values.current_hull + ship_values.hull_regen * delta)

	

func thrust():
	apply_impulse(Vector2(0,0),Vector2(ship_values.thrust,0).rotated(rotation - PI/2))


func rotate_left():
	angular_velocity = -ship_values.agillity 
	
func rotate_right():
	angular_velocity = ship_values.agillity

func recalc_values():
	ship_values.max_Shield = ship_values.max_Shield # TODO calculation
	ship_values.max_Hull = ship_values.max_Hull		
	ship_values.max_Crew = ship_values.max_Crew + commander.sociality * 2
	ship_values.mass = ship_values.current_crew * 0.07
	mass = ship_values.mass
	ship_values.thrust = commander.boldness *0.1
	ship_values.agillity = commander.responsiveness
	ship_values.sensor_thrength = commander.attention
	ship_values.shield_regen = commander.improvisation
	ship_values.hull_regen = commander.improvisation