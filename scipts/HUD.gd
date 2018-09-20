extends CanvasLayer

onready var crew = get_node("CrewBar")
onready var hull = get_node("HullBar")
onready var shield = get_node("ShieldBar")
onready var inventory = $CharMenu.inventory_gui

func _ready():
	var dim = Vector2(get_viewport().size.x / 4, get_viewport().size.y / 20)
	crew.rect_size = dim
	hull.rect_size = dim
	shield.rect_min_size = dim
	
	crew.rect_position = Vector2(20, get_viewport().size.y - 50) 
	hull.rect_position = Vector2(get_viewport().size.x / 2 - dim.x /2, get_viewport().size.y - 50)
	shield.rect_position = Vector2(get_viewport().size.x -dim.x - 20, get_viewport().size.y - 50)
	
	$IngameMenu/Control.hide()
	$CharMenu.hideMenu()
	pass
	
func set_bar_values( ship_values):
	crew.max_value = ship_values.max_Crew
	crew.value = ship_values.current_crew
	
	hull.max_value = ship_values.max_Hull
	hull.value = ship_values.current_hull
	
	shield.max_value = ship_values.max_Shield
	shield.value = ship_values.current_shield

func _input(event):
	if event.is_action_pressed("pause"):
		Globals.pause = not Globals.pause
		get_tree().paused = Globals.pause
	if event.is_action_pressed("menu"):
		if$IngameMenu/Control.visible == false:
			$IngameMenu/Control.show()
			$IngameMenu/TextureRect.show()
			Globals.pause = true
			get_tree().paused = Globals.pause
		else:
			$IngameMenu/Control.hide()
			$IngameMenu/TextureRect.hide()
			if $CharMenu.visible == false:
				Globals.pause = false
				get_tree().paused = Globals.pause
				
	if event.is_action_pressed("char_menu"):
		if $IngameMenu/Control.visible == false:
			if $CharMenu.visible == false:
				$CharMenu.showMenu()
				$CharMenu.setAttributes()
				Globals.pause = true
				get_tree().paused = Globals.pause
			else:
				$CharMenu.hideMenu()
				Globals.pause = false
				get_tree().paused = Globals.pause
