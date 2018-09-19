extends Area2D

var vel = Vector2()
var projectile_owner = ""

signal projectileHit

func _ready():
	hide()
	set_process(false)
	pass

func fire(pos, dir, speed ):
	$duration_timer.start()
	global_position = pos
	global_rotation = dir + PI /2
	vel = Vector2(speed, 0).rotated(dir)
	show()
	#avoid color artefacts
	$discharge_timer.start()
	set_process(true)
	
func _process(delta):
	global_position += vel * delta
	pass


func set_Color(color):
	#$Sprite.self_modulate = color
	$travel_light.color = color



func _on_projectile_body_entered(body):
	if not body.is_in_group(projectile_owner):
		emit_signal("projectileHit")
		queue_free()
	pass # replace with function body


func _on_duration_timer_timeout():
	queue_free()
	pass # replace with function body


func _on_discharge_timer_timeout():
	$travel_light.show()
	pass # replace with function body
