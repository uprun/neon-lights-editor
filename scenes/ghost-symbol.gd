extends Node2D

func fly_up():
	$"Rocket-engine".shift_position(Vector2(0, -get_size().y)) 

func get_size():
	var font = $name.get_theme_font("normal_font") as Font
	var size = $name.get_theme_font_size("normal_font_size")
	return font.get_string_size($name.text,HORIZONTAL_ALIGNMENT_LEFT, -1, size)

var text = null

func set_text(text):
	self.text = text
	(get_node("name") as RichTextLabel).text = text


func _on_rocketengine_destination_reached():
	queue_free()
