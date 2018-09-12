extends Node

export var commander_name = ""

# commander attributes
export var boldness = 1 		# influences thurst
export var thoroughness = 1 	# influences reload speed 
export var improvisation = 1 	# influences regeneration
export var organisation = 1 	# organisation influences storage size
export var sociality = 1 		# sociality influences crew size
export var responsiveness = 1 	# responsiveness influences ship agility
export var attention = 1 		# attetion influences the sensor accuacy

func setValue(attribute,value):
	match attribute:
		"Boldness":
			boldness = value
		"Thoroughness":
			thoroughness = value
		"Improvisation":
			improvisation = value
		"Organisation":
			organisation = value
		"Sociality":
			sociality = value
		"Responsiveness":
			responsiveness = value
		"Attention":
			attention = value
		
func getValue(attribute):
	match attribute:
		"Boldness":
			return boldness
		"Thoroughness":
			return thoroughness
		"Improvisation":
			return improvisation 
		"Organisation":
			return organisation 
		"Sociality":
			return sociality 
		"Responsiveness":
			return responsiveness 
		"Attention":
			return attention