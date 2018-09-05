extends Node

var SaveFileName = ".FDsave"

var friction = 0.9
var pause = false

var game_over = false

var current_scene = null
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
	
func load_json(filepath):
	var text_json = "{\"error\": false, \"data\": {\"player_id\": 1}}"
	var result_json = JSON.parse(text_json)
	var result = {}
	if result_json.error == OK:  # If parse OK
    	result = result_json.result

	else:  # If parse has errors
    	print("Error: ", result_json.error)
    	print("Error Line: ", result_json.error_line)
    	print("Error String: ", result_json.error_string)
	
	return result

func save_json(filepath, data):
	# Open a file
	var file = File.new()
	if file.open(filepath, File.WRITE) != 0:
		print("Error opening file")
		return

	file.store_line(data.to_json())
	file.close()

func goto_scene(path):
	var s = ResourceLoader.load(path)
	new_scene = s.instance()
	get_tree().root.add_child(new_scene)
	current_scene.queue_free()
	current_scene = new_scene
	
func new_game():
	game_over = false
	goto_scene("res://scenes/main.tscn")