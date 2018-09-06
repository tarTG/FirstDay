extends Node

#Contains all Game information like Ships, Components, Classes etc.

func saveGame(path):

	save_json(path)



func load_json(filepath):
	var save_game = File.new()
	if not save_game.file_exists(filepath):
		return # Error! We don't have a save to load.

    # We need to revert the game state so we're not cloning objects during loading. This will vary wildly depending on the needs of a project, so take care with this step.
    # For our example, we will accomplish this by deleting savable objects.
	var save_nodes = get_tree().get_nodes_in_group("PlayerSave")
	for i in save_nodes:
		i.queue_free()

    # Load the file line by line and process that dictionary to restore the object it represents
	save_game.open(filepath, File.READ)

	var current_line = parse_json(save_game.get_line())
	# First load world and player
	var player_data = current_line["player"]
	var new_object = load("res://scenes/Player.tscn").instance()

	Globals.player = new_object
	get_node(player_data["parent"]).add_child(new_object)
	Globals.goto_scene(player_data["level"])
	
	
	for i in player_data.keys():
		Globals.player.set(i, player_data[i])
	
	Globals.player.ship.recalc_values()
	save_game.close()
	pass

func save_json(filepath):
	# Open a file
	var save_game = File.new()
	save_game.open(filepath, File.WRITE)
	var save_data = {"player" : {},
					  "world" : []}
	#save some globals	
	var save_nodes = get_tree().get_nodes_in_group("PlayerSave")

	for i in save_nodes:
		save_data["player"] = i.call("save")
		save_game.store_line(to_json(save_data))
	save_game.close()

