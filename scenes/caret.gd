extends Node2D

func _draw():
	draw_line(Vector2(0, 0.0), Vector2(0, 80.0), Color.GREEN, 10.0)

var function_under_focus: Node2D
var insert_index = null

func _process(_delta):
	queue_redraw()

func insert_symbol(symbol):
	if function_under_focus != null and insert_index != null:
		function_under_focus.insert_symbol(symbol, insert_index+1)
		set_index(insert_index+1)
		
func remove_symbol():
	if function_under_focus != null and insert_index != null:
		function_under_focus.remove_symbol(insert_index)
		set_index(insert_index - 1)

func set_index (index):
	insert_index = index
	var use_position = function_under_focus.get_symbol_global_position_further_side(insert_index)
	$"Rocket-engine".update_position(use_position)
