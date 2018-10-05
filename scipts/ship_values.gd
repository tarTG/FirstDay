extends Node

# ship status
export var max_Shield = 0 # current shild status of the ship
export var max_Hull = 0   # current hull status of the ship
export var max_Crew = 1   # current crew members alive

var current_shield = 0 # current shield value
var current_hull = 0   # current hull value
var current_crew = 1   # current crew members


var shield_regen = 0  	# shield regeneration / second
var hull_regen = 0    	# hull regeneration / second

var mass = 0 				# current mass of the ship
var thrust = 0 				# current thrust of the ship
var agillity = 0 			# current agillity of the ship
var sensor_thrength = 1 	# current sensor threngt of the ship


func resetValues():
	max_Shield = 0
	max_Hull = 0
	max_Crew = 0
	shield_regen = 0
	hull_regen = 0
	mass = 0
	thrust = 0
	agillity = 0
	sensor_thrength = 1
	
func getAsDictionary():
	var ret = {
		 "Shield" : max_Shield,
		 "Hull" : max_Hull, 
		 "Crew" :max_Crew, 
		# "current_shield" : current_shield,
	#	 "current_hull" : current_hull,
	#	 "current_crew" : current_crew,
		 "Shield regen" : shield_regen,
		 "Hull regen" : hull_regen,		
		 "Mass" : mass,
		 "Thrust" : thrust,
		 "Agillity" : agillity,
		 "Sensor thrength" : sensor_thrength}
	return ret