extends Node

onready var ship_vals = get_node("Player/ship_template/ship_values")
onready var HUD = get_node("HUD")

func _ready():
	HUD.set_bar_values(ship_vals)
	pass

func _process(delta):
	HUD.set_bar_values(ship_vals)
#	$ParallaxBackground/ParallaxLayer.position = $Player/ship_template.global_position
#	$ParallaxBackground/ParallaxLayer.rotation = $Player/ship_template.rotation 