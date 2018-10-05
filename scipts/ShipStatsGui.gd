extends HBoxContainer

var currentKeys = []
var entriesPerBar = 4

func _ready():
	pass


func generate(dict):

	for i in range(0,(dict.size() / entriesPerBar) +1):
		var cont = VBoxContainer.new()
		cont.set_h_size_flags(SIZE_EXPAND_FILL)
		cont.set_v_size_flags(SIZE_EXPAND_FILL)		
		add_child(cont)
	currentKeys = dict.keys()
	
	for key in currentKeys:
		get_child(currentKeys.find(key)/entriesPerBar).add_child(addStat(key,dict[key]))
	

func updateStats(dict):

	for i in currentKeys:
		if dict.has(i):
			find_node(i,true,false) .get_child(1).text = String(dict[i])

				
func addStat(titel, _value):
	var container = HBoxContainer.new()
	container.set_h_size_flags(SIZE_EXPAND_FILL)
	container.set_v_size_flags(SIZE_EXPAND_FILL)
	container.name = titel
	var label = Label.new()
	label.set_h_size_flags(SIZE_EXPAND_FILL)
	label.set_v_size_flags(SIZE_EXPAND_FILL)	
	label.align = ALIGN_CENTER
	label.valign = VALIGN_CENTER
	label.name = "label"
	label.text = titel
	var value = Label.new()
	value.set_h_size_flags(SIZE_EXPAND_FILL)
	value.set_v_size_flags(SIZE_EXPAND_FILL)
	value.align = ALIGN_CENTER
	value.valign = VALIGN_CENTER
	value.name = "value"
	value.text = String(_value)
	container.add_child(label)
	container.add_child(value)
	return container
