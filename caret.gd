extends Node2D


func _draw():
	draw_line(Vector2(0, -40.0), Vector2(0, 40.0), Color.GREEN, 10.0)
	pass  # Your draw commands here.

var next_position: Vector2
var speed = 0
var function_under_focus: Node2D
var insert_index = null
func _process(_delta):
	if next_position != position:
		var diff = (position - next_position)
		var length = diff.length()
		if  length < 1:
			position = next_position
			speed = 0
		else:
			if speed * 2 > length:
				speed = length * 0.8
			else:
				speed = (speed + 1) * 1.1#1.6
			position -= diff.normalized() * speed#* _delta
	queue_redraw()


func insert_symbol(symbol):
	if function_under_focus != null and insert_index != null:
		function_under_focus.insert_symbol(symbol, insert_index)
		next_position = function_under_focus.get_symbol_global_position_further_side(insert_index)
		insert_index += 1
		
func remove_symbol():
	if function_under_focus != null and insert_index != null:
		insert_index -= 1
		function_under_focus.remove_symbol(insert_index)
		
		next_position = function_under_focus.get_symbol_global_position_further_side(insert_index-1)
		
# Called when the node enters the scene tree for the first time.
func _ready():
	next_position = position
	pass # Replace with function body.
