extends Node


var database_item_path = "res://database/items.json"

func _ready():
	var itemData = get_item(2)
	if itemData == null: return
	print("ID: " + String(itemData["id"]))
	print("Price: " + String(itemData["sell_price"]))

func get_item(id):
	var itemData = {}
	itemData = LoadSave.load_items(database_item_path)
	if !itemData.has(String(id)):
		print("Item does not exist.")
		return 
	itemData[String(id)]["id"] = int(id)
	return itemData[String(id)]


