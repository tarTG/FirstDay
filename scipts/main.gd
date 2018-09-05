extends Node

var ship_vals = null
onready var HUD = get_node("HUD")

var player

func _ready():
	add_child(Globals.player)
	ship_vals = get_node("player/ship_template/ship_values")
	HUD.set_bar_values(ship_vals)
	print(String($player/player_commander.boldness))
	pass

func _process(delta):
	HUD.set_bar_values(ship_vals)
#	$ParallaxBackground/ParallaxLayer.position = $Player/ship_template.global_position
#	$ParallaxBackground/ParallaxLayer.rotation = $Player/ship_template.rotation 