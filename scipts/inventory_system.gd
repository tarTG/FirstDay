extends Control
var item_list = []

onready var slot = load("res://scenes/item_slot.tscn")

export var inventory_size = 10
export var inventory_columns = 1

onready var item_picking

func _ready():
	
#	for i in range(0,:
#		item_list.append(get_node("slot_list").get_child(i))

	item_picking = $item_picking

func init(items):
	$GridContainer.columns = inventory_columns
	if items.size() > inventory_size:
		return false
	for i in range(0, inventory_size):
		item_list.append(slot.instance())
		item_list[i].slot_id = i
		item_list[i].item_id = 0
		$GridContainer.add_child(item_list[i])
	for i in range (0,items.size()):
		add_item(items[i])

	pass

func change_inventory_size(size):
	
	if(inventory_size == size): # nothing to do here
		return
	if(inventory_size < size): # just extend size with empty slots
		for i in range(inventory_size, size):
			item_list.append(slot.instance)
			item_list[i].slot_id = i
			item_list[i].item_id = 0
			$GridContainer.add_child(item_list[i])
		inventory_size = size
	else: # throw away unused items
		var throw_items = []
		for i in range(size, inventory_size):
			if item_list[i].item_id == 0:
				continue
			throw_items.append(item_list[i].item_id)
			$GridContainer.remove_child(item_list[i])
			item_list.remove(item_list[i])
		inventory_size = size
		return throw_items



func add_item(item_id):
		
	for i in range(item_list.size()):
		if item_list[i].item_id == item_id:
			print("1")
			item_list[i].count_num += 1
			return true
		elif item_list[i].item_id == 0:
			print("2")
			item_list[i].item_id = item_id
			item_list[i].count_num += 1
			return true
			
