extends Node2D
# 60 lines of code with comments should be enough for proper code
# also try to not update properties of parent directly

var symbol_scene = preload("res://scenes/symbol.tscn")
var text = ""

signal symbol_has_been_removed(symbol, position_of_symbol)

func _ready():
	text = ">"
	for x in text:
		var clone = symbol_scene.instantiate()
		add_child(clone)
		clone.set_text(x)

func insert_symbol(symbol, index, position):
	var clone = symbol_scene.instantiate()
	add_child(clone)
	#var clone_position = get_viewport_rect().size
	#clone_position.x = clone_position.x / 2
	var clone_position = position
	
	
	clone_position.y -= clone.get_size().y
	(clone as Node2D).global_position = clone_position
	move_child(clone, index)
	clone.set_text(symbol)
	update_symbols_from_index(index)

func update_symbols_from_index(index):
	for index_to_update in range(index, get_child_count()):
		var symbol_to_update = get_child(index_to_update)
		symbol_to_update.update_position()
		if symbol_to_update.position_changed() == false:
			break

func remove_symbol(index):
	var symbol = get_child(index)
	remove_child(symbol)
	symbol_has_been_removed.emit(symbol)
	symbol.queue_free()
	update_symbols_from_index(index)

func get_symbol_global_position_further_side(index):
	var symbol_position = get_child(index).get_further_side_position()
	return to_global(symbol_position)

func get_text():
	var result = ""
	for n in get_children():
		result += n.text
	return result

func find_closest_symbol_index(position: Vector2):
	var closest_index = 0
	var closest_distance = (get_symbol_global_position_further_side(0) - position).length()
	for n in get_children():
		var symbol_position = n.get_further_side_position()
		var global_symbol_position = to_global(symbol_position)
		var distance = (global_symbol_position - position).length()
		if distance < closest_distance:
			closest_distance = distance
			closest_index = n.get_index()
	return closest_index
