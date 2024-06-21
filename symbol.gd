extends Node2D

var function_range: Array = Array()

func previous_symbol():
	var index = get_index()
	if index > 0:
		return get_parent().get_child(index - 1)
	return null

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
		if previous_symbol() != null:
			function_range[0] -= 1
			previous_symbol().mark_as_function(function_range)
	else:
		function_range[0] += 1
	pass

func get_size():
	var font = $name.get_theme_font("normal_font") as Font
	var size = $name.get_theme_font_size("normal_font_size")
	return font.get_string_size($name.text,HORIZONTAL_ALIGNMENT_LEFT, -1, size)


func set_text(text):
	if text == "(":
		($name as RichTextLabel).add_theme_color_override("default_color", Color.CHARTREUSE)
		if previous_symbol() != null:
			var range = [get_index() - 1, get_index() -1]
			previous_symbol().mark_as_function(range)
	if text == ")":
		($name as RichTextLabel).add_theme_color_override("default_color", Color.CHARTREUSE)
	(get_node("name") as RichTextLabel).text = text


func _on_name_gui_input(event):
	if (event is InputEventMouseButton && event.pressed && event.button_index == 1):
		print("Clicked", function_range)
		get_parent().populate_new_function(function_range[0], function_range[1])
			
	pass # Replace with function body.
