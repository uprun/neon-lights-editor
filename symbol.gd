extends Node2D

var _previous_symbol = null
var index = null
var function_range: Array = Array()
var function_parent = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func mark_as_function(range: Array):
	function_range = range
	var text = $name.text
	if text != ")" and text != "(" and text != "." and text != " ":
		($name as RichTextLabel).add_theme_color_override("default_color", Color.CORNFLOWER_BLUE)
		if _previous_symbol != null:
			function_range[0] -= 1
			_previous_symbol.mark_as_function(function_range)
	else:
		function_range[0] += 1
	pass

func get_size():
	var font = $name.get_theme_font("normal_font") as Font
	var size = $name.get_theme_font_size("normal_font_size")
	return font.get_string_size($name.text,HORIZONTAL_ALIGNMENT_LEFT, -1, size)
	#return (get_node("name") as RichTextLabel).size


func set_text(text):
	if text == "(":
		($name as RichTextLabel).add_theme_color_override("default_color", Color.CHARTREUSE)
		if _previous_symbol != null:
			var range = [index - 1, index -1]
			_previous_symbol.mark_as_function(range)
	if text == ")":
		($name as RichTextLabel).add_theme_color_override("default_color", Color.CHARTREUSE)
		
	
		
	(get_node("name") as RichTextLabel).text = text


func _on_name_gui_input(event):
	if (event is InputEventMouseButton && event.pressed && event.button_index == 1):
		print("Clicked", function_range)
		if function_parent != null:
			var function_name = (function_parent.text as String).substr(function_range[0], function_range[1] - function_range[0] + 1)
			function_parent.populate_new_function(function_name)
			print(function_name)
	pass # Replace with function body.
