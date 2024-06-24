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

	
var speed = 0
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
				speed = (speed + 1) * 1.1
			position -= diff.normalized() * speed

func fly_up():
	next_position.y -= get_size().y

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

func get_further_side_global_position():
	var size = get_size()
	
	var cursor_next_position = get_parent().to_global(next_position)
	print('next', cursor_next_position)
	
	cursor_next_position.y += size.y/2
	cursor_next_position.x += size.x
	return cursor_next_position

func _on_name_gui_input(event):
	#print(event)
	if (event is InputEventMouseButton && event.pressed && event.button_index == 1):
		var click_local = (event as InputEventMouseButton)
		var size = get_size()
		var cursor_next_position = global_position
		var caret = get_parent().get_parent().get_node("Caret")
		cursor_next_position.y += size.y/2 
		caret.function_under_focus = get_parent()
		caret.insert_index = get_index()
		if click_local.position.x > size.x/2:
			cursor_next_position.x += size.x
			caret.insert_index += 1
		print(cursor_next_position)
		caret.next_position = cursor_next_position
