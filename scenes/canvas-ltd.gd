extends Node2D

var function_scene = preload("res://scenes/function-node.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
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
			var symbol = char(event.unicode)
			print(symbol)
			$Caret.insert_symbol(symbol)

func populate_new_function(name: String, x, y):
	var clone2 = function_scene.instantiate()
	var new_name = name + ".js"
	clone2.file_name_1 = new_name
	clone2.position.x = x + 100
	clone2.position.y = y
	self.add_child(clone2)
