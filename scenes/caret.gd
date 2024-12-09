extends Node2D

var height = 80.0

func _draw():
	draw_line(Vector2(0, 0.0), Vector2(0, height), Color.GREEN, 10.0)

var function_under_focus: Node2D
var insert_index = null

func _process(_delta):
	queue_redraw()

func insert_symbol(symbol):
	if function_under_focus != null and insert_index != null:
		function_under_focus.insert_symbol(symbol, insert_index+1, position)
		set_index(insert_index+1)
		
func remove_symbol():
	if function_under_focus != null and insert_index != null:
		function_under_focus.remove_symbol(insert_index)
		set_index(insert_index - 1)
		
func move_left():
	if function_under_focus != null and insert_index != null:
		set_index(insert_index - 1)

func move_right():
	if function_under_focus != null and insert_index != null:
		set_index(insert_index + 1)

func move_up():
	if function_under_focus != null and insert_index != null:
		var projected_position = position
		projected_position.y -= height
		var index = function_under_focus.find_closest_symbol_index(projected_position)
		set_index(index)
		
func move_down():
	if function_under_focus != null and insert_index != null:
		var projected_position = position
		projected_position.y += height
		var index = function_under_focus.find_closest_symbol_index(projected_position)
		set_index(index)


var desired_locations = []

func set_index (index):
	insert_index = index
	var use_position = function_under_focus.get_symbol_global_position_further_side(insert_index)
	var copy_y = use_position
	copy_y.y = position.y
	$"Rocket-engine".update_position(use_position)

func _on_rocketengine_request_to_shift_position(shift):
	position += shift

func _on_rocketengine_request_to_set_position(another_position):
	position = another_position
