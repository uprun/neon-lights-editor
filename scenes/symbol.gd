extends Node2D

# so I want to be able to edit the code
# and to see how it executes
# what can I do with minimal resources?
# I can be recursive as much a possible

var text = null

signal set_caret_at_index(index)

func previous_symbol():
	var index = get_index()
	if index > 0:
		return get_parent().get_child(index - 1)
	return null

func get_size():
	var font = $name.get_theme_font("normal_font") as Font
	var size = $name.get_theme_font_size("normal_font_size")
	return font.get_string_size($name.text,HORIZONTAL_ALIGNMENT_LEFT, -1, size)

func update_position():
	var previous = previous_symbol()
	if previous != null:
		$"Rocket-engine".update_position(previous.get_further_side_position())

func position_changed():
	return $"Rocket-engine".position_changed()

func set_text(text):
	self.text = text
	(get_node("name") as RichTextLabel).text = text
	update_position()

func get_further_side_position():
	var size = get_size()
	var cursor_next_position = ($"Rocket-engine".get_destination_location)
	cursor_next_position.x += size.x
	if text == '\n':
		cursor_next_position.y += size.y
		cursor_next_position.x = 0
	return cursor_next_position

func _on_name_gui_input(event):
	if (event is InputEventMouseButton && event.pressed && event.button_index == 1):
		var click_local = (event as InputEventMouseButton)
		var size = get_size()
		var caret = get_parent().get_parent().get_node("Caret")
		caret.function_under_focus = get_parent()
		var caret_index = get_index() - 1
		if click_local.position.x > size.x/2:
			caret_index += 1
		caret.set_index(caret_index)

func _on_rocketengine_request_to_set_position(another_position):
	position = another_position

func _on_rocketengine_request_to_shift_position(shift):
	position += shift
