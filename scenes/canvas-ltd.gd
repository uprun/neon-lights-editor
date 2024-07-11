extends Node2D

var function_scene = preload("res://scenes/function-node.tscn")
var ghost_symbol_scene = preload("res://scenes/ghost-symbol.tscn")

func _ready():
	
	$Caret.function_under_focus = $"function-node"
	$Caret.set_index(0)

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed:
			print(event)
			
			if event.keycode == KEY_LEFT:
				$Caret.move_left()
				return
			
			if event.keycode == KEY_RIGHT:
				$Caret.move_right()
				return
			
			if event.keycode == KEY_BACKSPACE:
				print("back space")
				$Caret.remove_symbol()
				return

			if event.keycode == KEY_ESCAPE:
				print("escape")
				return
			
			if event.keycode == KEY_ENTER:
				$Caret.insert_symbol('\n')
				return
			
			if event.keycode == KEY_UP:
				$Caret.move_up()
				return
			
			if event.keycode == KEY_DOWN:
				$Caret.move_down()
				return
			
			var symbol = char(event.unicode)
			print(symbol)
			$Caret.insert_symbol(symbol)

func _on_functionnode_symbol_has_been_removed(symbol):
	var ghost_symbol = ghost_symbol_scene.instantiate()
	ghost_symbol.global_position = symbol.global_position
	ghost_symbol.set_text(symbol.text)
	add_child(ghost_symbol)
