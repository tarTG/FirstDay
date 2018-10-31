extends GridContainer

func _ready():
	pass

func _process(delta):
	var comp = Globals.player.ship.components
	for i in comp:
		print(comp[i].component_stats["id"])
		find_node(i).item_id = comp[i].component_stats["id"]
		find_node(i).count_num = 1