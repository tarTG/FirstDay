extends HBoxContainer

export var min_value = 1
export var max_value = 100
export var current_val = 0

export var label_name = ""

signal value_update

func _ready():
	current_val = Globals.default_attribute_value
	$StatLabel.text = label_name
	display_val()
	

func disableButton(minus,plus):
	$stat_sub.disabled = minus
	$stat_add.disabled = plus
	


func _on_stat_sub_button_down():
	current_val -= 1
	display_val()
	if(current_val == min_value):
		disableButton(true,false)
	else:
		disableButton(false,false)
	emit_signal("value_update")



func _on_stat_add_button_down():
	current_val += 1
	display_val()
	if(current_val == max_value):
		disableButton(false,true)
	else:
		disableButton(false,false)
	emit_signal("value_update")



func display_val():
	$stat_val.text = String(current_val)