extends Node

var SaveFileName = ".FDsave"

var friction = 0.9
var pause = false

var game_over = false

var current_scene = null
var current_scene_path = ""
var new_scene = null

var player = null 

var default_attribute_value = 5 
var default_attribute_points = 10

func _ready():
	var player_inst = load("res://scenes/Player.tscn")
	player = player_inst.instance()
	player.set_name("player")	
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() -1)
	

func goto_scene(path):
	var s = ResourceLoader.load(path)
	current_scene_path = path
	new_scene = s.instance()
	current_scene.queue_free()
	get_tree().root.remove_child(current_scene)
	get_tree().root.add_child(new_scene)
	current_scene = new_scene
	
	if new_scene.is_in_group("level") and not get_tree().root.has_node(player.get_path()):
		get_tree().root.add_child(player)

		

	
func new_game():
	game_over = false
	goto_scene("res://scenes/main.tscn")
	
func save():
	return {
		"current_scene" : current_scene_path
		}