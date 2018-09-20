extends Node

var default_component_stats = {
	"component_type" : null,
	"texture" : null,
	"normal_texture" : null,
	"weapon_type" : null,
	"weapon_color" : Color(0,0,0),
	"weapon_damage" : 0,
	"weapon_reload_time" : 0,
	"weapon_size" : Vector2(1,1),
	"weapon_speed" : 0,
	"component_owner" : "default",
	"shield" : 0,
	"hull" : 0,
	"live_support" : 0,
	"thrust" : 0 ,
	"position_control" : 0,
	"sensors" : 0,
	"shield_regen" : 0,
	"hull_regen" : 0,
	"sensor_thrength" : 0,
	"weight" : 0
	}

var weapon_types = ["laser","kinetic"]

var component_types = { "life_support":"life_support",
							"command_center" : "command_center",
							"engine" : "engine",
							"top_front" : "top_front",
							"top" : "top",
							"top_back" : "top_back" ,
							"bottom" : "bottom",
							"bottom_front": "bottom_front",
							"bottom_back" :"bottom_back"}


func generateShip(component_type, level):
	var ret = {
		"component_type" : component_type,
	"texture" : "res://art/demo_component.png",
	"normal_texture" : "res://art/demo_component_normal.png",
	"weapon_type" : "laser",
	"weapon_color" : Color(0,0,0),
	"weapon_damage" : 0,
	"weapon_reload_time" : 0,
	"weapon_size" : Vector2(1,1),
	"weapon_speed" : 0,
	"component_owner" : "default",
	"shield" : 0,
	"hull" : 0,
	"live_support" : 0,
	"thrust" : 0 ,
	"position_control" : 0,
	"sensors" : 0,
	"shield_regen" : 0,
	"hull_regen" : 0,
	"sensor_thrength" : 0,
	"weight" : 0
	}
	return ret
	