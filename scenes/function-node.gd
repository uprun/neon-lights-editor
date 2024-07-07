extends Node2D

var symbol_scene = preload("res://scenes/symbol.tscn")
var ghost_symbol_scene = preload("res://scenes/ghost-symbol.tscn")
var text = ""

var folder_path = "/Users/almostfox/Documents/projects/WebPad/wwwroot/js/"
var file_name_1: String = "AddInformationToExistingOne.js"

func combined_path():
	return folder_path + file_name_1


func read_file_content():
	var file = FileAccess.open(combined_path(), FileAccess.READ)
	var content = file.get_as_text()
	return content

# Called when the node enters the scene tree for the first time.
func _ready():
	
	text = ">"
	for x in text:
		var clone = symbol_scene.instantiate()
		add_child(clone)
		clone.set_text(x)

func insert_symbol(symbol, index):
	var clone = symbol_scene.instantiate()
	add_child(clone)
	var clone_position = get_viewport_rect().size
	clone_position.x = clone_position.x / 2
	(clone as Node2D).global_position = clone_position
	move_child(clone, index)
	clone.set_text(symbol)
	update_symbols_from_index(index)
	parse()

func update_symbols_from_index(index):
	for index_to_update in range(index, get_child_count()):
		var symbol_to_update = get_child(index_to_update)
		symbol_to_update.update_position()
		if symbol_to_update.position_changed() == false:
			break

func remove_symbol(index):
	var symbol = get_child(index)
	remove_child(symbol)
	var ghost_symbol = ghost_symbol_scene.instantiate()
	ghost_symbol.global_position = symbol.global_position
	ghost_symbol.set_text(symbol.text)
	symbol.queue_free()
	get_parent().add_child(ghost_symbol)
	ghost_symbol.fly_up()
	update_symbols_from_index(index)
	parse()

func get_symbol_global_position_further_side(index):
	var symbol_position = get_child(index).get_further_side_position()
	return to_global(symbol_position)

func get_text():
	var result = ""
	for n in get_children():
		result += n.text
	return result

var parsed = []

var memory = { "trains": [{"delay": 10}, {"delay": 25}, {"delay": 100, "location": "Germany"}] }

func parse_collection(to_parse: String):
	var symbol = to_parse
	if symbol in memory:
		return memory[symbol]
	if to_parse.contains(" in "):
		to_parse.split(" in ")
		#apply location filtering
		pass
		

func parse():
	parsed = []
	var to_parse = get_text()
	print("text is: ", to_parse)
	if to_parse.begins_with("> "):
		to_parse = to_parse.substr(2)
	if to_parse.begins_with(">"):
		to_parse = to_parse.substr(1)
		
	if to_parse.begins_with("What is an average ") and to_parse.contains(" of "):
		var splitted = to_parse.split(" of ")
		if splitted.size() > 2:
			print("too complex question because multiple \" of \" usage")
			return
		if splitted.size() == 2:
			var first = splitted[0] as String
			var potential_property = first.substr("What is an average".length()).replace(" ", "")
			var collection = parse_collection(splitted[1])
			return
		if splitted.size() < 2:
			print("incomplete question")
		
	
	
