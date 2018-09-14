extends Area2D

var vel = Vector2()

signal projectileHit

func _ready():
	hide()
	set_process(false)
	pass

func fire(pos, dir, speed ):
	show()
	$discharge_timer.start()
	$duration_timer.start()
	position = pos
	vel = Vector2(speed, 0).rotated(dir)
	set_process(true)
	
func _process(delta):
	position += vel * delta
	pass


func set_Color(color):
	self_modulate = color
	$travel_light.color = color
	$discharge_light.color = color


	
	

func _on_discharge_timer_timeout():
	$discharge_light.hide()
	pass


func _on_projectile_body_entered(body):
	emit_signal("projectileHit")
	queue_free()
	pass # replace with function body


func _on_duration_timer_timeout():
	queue_free()
	pass # replace with function body
