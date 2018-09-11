
extends Button

onready var count_text= $count_text
var count_num
export(int) var slot_id
export(int) var item_id
var item_data
onready var invent_sys =  get_parent().get_parent()

onready var timer = $Timer
onready var split_item = false
onready var detail = $detail


func _ready():
#	item_data = get_node("ItemData")

	item_id = 0
	count_num = 0

	
func _process(delta):
	refresh()
		
func refresh():
	icon = load(GlobalDatabase.get_item_image(item_id))
	if count_num == 0:
		item_id = 0
	if count_num > 1:
		count_text.set_text(String(count_num))
	else:
		count_text.set_text("")
	### split item timer
	if split_item == true:
		timer.set_wait_time(0.1)
		if timer.time_left <= 0:
			if count_num > 0:
				invent_sys.item_picking.count_num += 1
				count_num -= 1
				timer.start()
	### refresh detail
	$detail/values/name.text = "test"
#	get_node("detail/v/name").set_text(str(item_data.get_item_name(item_id)))
#	get_node("detail/v/hp").set_text("HP : "+str(item_data.get_item_hp(item_id)))
#	get_node("detail/v/mp").set_text("MP : "+str(item_data.get_item_mp(item_id)))
#	get_node("detail/v/atk").set_text("Attack : "+str(item_data.get_item_attack(item_id)))
#	get_node("detail/v/speed").set_text("Speed : "+str(item_data.get_item_speed(item_id)))
#	get_node("detail/v/def").set_text("Defend : "+str(item_data.get_item_defend(item_id)))
#	get_node("detail/v/cost").set_text("Cost : "+str(item_data.get_item_cost(item_id)))


func _gui_input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("menu_select"):
			if item_id != 0:
				if item_id == invent_sys.item_picking.item_id: # if same type is selected, increase counter
					count_num += invent_sys.item_picking.count_num
					invent_sys.item_picking.item_id = 0
					invent_sys.item_picking.count_num = 0
				elif invent_sys.item_picking.item_id == 0: ## no item selected, select this one
					invent_sys.item_picking.item_id = item_id
					invent_sys.item_picking.count_num = count_num
					count_num = 0
					item_id = 0
					
					 #item selected and not the same type, switch objects
				elif item_id != invent_sys.item_picking.item_id and invent_sys.item_picking.item_id != 0:
					var tmp_item_id = invent_sys.item_picking.item_id
					var tmp_count_num = invent_sys.item_picking.count_num
					invent_sys.item_picking.item_id = item_id
					invent_sys.item_picking.count_num = count_num
					item_id = tmp_item_id
					count_num = tmp_count_num
			elif item_id == 0: #if slot is emtpy
				item_id = invent_sys.item_picking.item_id
				count_num = invent_sys.item_picking.count_num
				invent_sys.item_picking.item_id = 0
				invent_sys.item_picking.count_num = 0
		elif event.is_action_pressed("menu_split"):
			if count_num == 0:
				return
			if invent_sys.item_picking.item_id == 0: # no item selected, reduce counter
				invent_sys.item_picking.item_id = item_id
				invent_sys.item_picking.count_num += 1
				count_num -= 1
				timer.set_wait_time(0.5)
				timer.start()
				split_item = true
			elif invent_sys.item_picking.item_id == item_id: # same item selected, increase counter
				invent_sys.item_picking.item_id = item_id
				invent_sys.item_picking.count_num += 1
				count_num -= 1
				timer.set_wait_time(0.5)
				timer.start()
				split_item = true
			elif count_num == 0 and invent_sys.item_picking.count_num > 0: # empty slot, add item
				item_id = invent_sys.item_picking.item_id
				count_num += 1
				invent_sys.item_picking.count_num -= 1
		elif event.is_action_pressed("menu_split"):
			split_item = false
	if event is InputEventMouseMotion:
		var m = get_global_mouse_position()
		
		detail.rect_position = Vector2(m.x+10, m.y+10)
		


func _on_item_slot_mouse_entered():
	if item_id != 0:
		detail.set_as_toplevel(true)
		detail.show()


func _on_item_slot_mouse_exited():
	#detail.set_as_toplevel(false)
	detail.hide()



func _on_item_slot_hide():
	detail.hide()
	pass # replace with function body
