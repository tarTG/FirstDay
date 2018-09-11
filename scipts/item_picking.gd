
extends Button

var count_text
var count_num
var item_data ={}
var item_id = 0

func _ready():

	count_text = get_node("Label")
	count_num = 0

	
	
func _process(delta):
	refresh()
	if count_num > 1:
		count_text.set_text(str(count_num))
	else:
		count_text.set_text("")

	
func refresh():
	var m =get_global_mouse_position()

	rect_global_position = Vector2(m.x+10, m.y+10)
	icon = load(GlobalDatabase.get_item_image(item_id))
	rect_size = Vector2(40,40)
	show_hide()
	
func show_hide():
	if count_num == 0:
		item_id = 0
		hide()
	else:
		show()


