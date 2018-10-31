extends Node


var database_item_path = "res://database/items.json"

var itemData = {}

func _ready():
	itemData = LoadSave.load_items(database_item_path)

func get_item(id):
	if !itemData.has(String(id)):
		print("Item does not exist.")
		return 
	itemData[String(id)]["id"] = int(id)
	return itemData[String(id)]

func get_item_image(id):
	if !itemData.has(String(id)):
		print("Item does not exist.")
		return 
#	itemData[String(id)]["id"] = int(id)
	return itemData[String(id)]["texture"]

func add_item(id, item):
	itemData[String(id)] = item