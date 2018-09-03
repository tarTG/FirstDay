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