
extends CollisionShape2D

onready var projectile = load("res://scenes/projectile.tscn")


# Component Stats
var component_stats = {
	"component_type" : null,
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
	"sensor_thrength" : 0,
	"weight" : 0
	}

func _ready():
	$discharge_timer.stop()
	$reload_timer.stop()
	$front_position/discharge_light.hide()

func disable():
	hide()
	disabled = true



func fire():
	if component_stats.weapon_type == null:
		return
	if not $reload_timer.is_stopped():
		return
	var p = projectile.instance()
	p.set_Color(component_stats.weapon_color)
	p.scale = component_stats.weapon_size
	p.projectile_owner = component_stats.component_owner
	Globals.player.add_child(p)
	$reload_timer.wait_time = component_stats.weapon_reload_time
	$discharge_timer.start()
	$front_position/discharge_light.show()
	$reload_timer.start()
	p.fire($front_position.global_position,$front_position.global_rotation - PI/2,component_stats.weapon_speed)
	pass

func _on_discharge_timer_timeout():
	$front_position/discharge_light.hide()
	pass
	
func load_component(values):
	component_stats = values
	if component_stats.component_type != null:
		$front_position/discharge_light.color = component_stats.weapon_color
		show()
		disabled = false
	
	