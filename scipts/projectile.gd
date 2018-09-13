extends Area2D

var direction
var speed

func _ready():
	hide()
	set_process(false)
	pass

func fire(dir, spd):
	show()
	$discharge_timer.start()
	$duration_timer.start()
	direction = dir
	speed = spd
	set_process(true)
	
func _process(delta):
	pass


func set_Color(color):
	self_modulate = color
	$travel_light.color = color
	$discharge_light.color = color


	
	

func _on_discharge_timer_timeout():
	$discharge_light.hide()
	pass


func _on_projectile_body_entered(body):
	pass # replace with function body


func _on_duration_timer_timeout():
	
	pass # replace with function body
