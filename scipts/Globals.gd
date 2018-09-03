extends Node

var friction = 0.9
var pause = false

var game_over = false
var score = 0
var level = 0
var paused = false
var current_scene = null
var new_scene = null

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() -1)
	
func goto_scene(path):
	var s = ResourceLoader.load(path)
	new_scene = s.instance()
	get_tree().root.add_child(new_scene)
	current_scene.queue_free()
	current_scene = new_scene
	
func new_game():
	game_over = false
	score = 0
	level = 0
	goto_scene("res://scenes/main.tscn")