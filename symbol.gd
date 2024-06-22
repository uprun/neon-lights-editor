extends Node2D


# so I want to be able to edit the code
# and to see how it executes
# what can I do with minimal resources?
# I can be recursive as much a possible

func previous_symbol():
	var index = get_index()
	if index > 0:
		return get_parent().get_child(index - 1)
	return null
	
func next_symbol():
	var index = get_index()
	if index < get_parent().get_child_count() - 1:
		return get_parent().get_child(index + 1)
	return null

# Called when the node enters the scene tree for the first time.
func _ready():
	next_position = position
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if next_position != null and next_position != position:
		position = next_position
	pass

func get_size():
	var font = $name.get_theme_font("normal_font") as Font
	var size = $name.get_theme_font_size("normal_font_size")
	return font.get_string_size($name.text,HORIZONTAL_ALIGNMENT_LEFT, -1, size)

func update_position():
	var previous = previous_symbol()
	if previous != null:
		next_position = previous.next_position
		var psize = previous.get_size()
		next_position.x += psize.x
		
		if previous.text == '\n':
			next_position.y += psize.y
			next_position.x = 0
	if next_position != position:
		var next = next_symbol()
		if next != null:
			next.update_position()

var text = null
var next_position = null
func set_text(text):
	self.text = text
	(get_node("name") as RichTextLabel).text = text
	update_position()


func _on_name_gui_input(event):
	#print(event)
	if (event is InputEventMouseButton && event.pressed && event.button_index == 1):
		var click_local = (event as InputEventMouseButton)
		get_parent().get_parent().get_node("Caret").next_position = click_local.global_position
		print()
		#get_parent().populate_new_function(function_range[0], function_range[1])
			
	pass # Replace with function body.
