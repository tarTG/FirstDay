
extends CollisionShape2D

onready var projectile = load("res://scenes/projectile.tscn")


# Component Stats
var component_stats = ShipGeneration.default_component_stats

func _ready():
	$discharge_timer.stop()
	$reload_timer.stop()
	$front_position/discharge_light.hide()

func disable():
	hide()
	disabled = true

func setLight(value):
	$front_position/search_light.visible = value


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
		$texture.texture = load(values["texture"])
		$texture.normal_map = load(values["normal_texture"])
		show()
		disabled = false
	

	