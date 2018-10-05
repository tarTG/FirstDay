extends Control
var item_list = []

onready var slot = load("res://scenes/item_slot.tscn")

export var inventory_size = 0
export var inventory_columns = 1

onready var item_picking = $item_picking

func _ready():
	pass

func init():
	$ScrollContainer/GridContainer.columns = inventory_columns
	pass

func change_inventory_size(size):
	
	if(inventory_size == size): # nothing to do here
		return
	if(inventory_size < size): # just extend size with empty slots
		item_list.resize(size +1)
		for i in range(inventory_size, size+1):
			item_list[i] =slot.instance()
			item_list[i].slot_id = i
			item_list[i].item_id = 0
			$ScrollContainer/GridContainer.add_child(item_list[i])
		inventory_size = size
	else: # throw away unused items
		var throw_items = []
		for i in range(size, inventory_size):
			if item_list[i].item_id != 0:
				throw_items.append(item_list[i].item_id)
			
			$ScrollContainer/GridContainer.remove_child(item_list[i])
			item_list.remove(item_list[i].slot_id -1)
		inventory_size = size
		return throw_items

func load(items):
	item_list.resize(items.size())
	for i in range(items.size()):
		item_list[i] = slot.instance()
		var slot = item_list[items[i]["slot"]]
		slot.slot_id = items[i]["slot"]
		slot.item_id = items[i]["item_id"]
		slot.count_num = items[i]["count"]
		$ScrollContainer/GridContainer.add_child(item_list[i])

func add_item(item_id):
		
	for i in range(item_list.size()):
		if item_list[i].item_id == item_id:
			
			item_list[i].count_num += 1
			return true
		elif item_list[i].item_id == 0:
			
			item_list[i].item_id = item_id
			item_list[i].count_num += 1
			return true
			
