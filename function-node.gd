extends Node2D

var symbol_scene = preload("res://symbol.tscn")
var text = ""

var folder_path = "/Users/almostfox/Documents/projects/WebPad/wwwroot/js/"
var file_name_1: String = "AddInformationToExistingOne.js"

func combined_path():
	return folder_path + file_name_1
	
func populate_new_function(name: String):
	self.get_parent().populate_new_function(name, max_x + position.x, position.y)

var max_x = 0
var max_y = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	var file = FileAccess.open(combined_path(), FileAccess.READ)
	var content = file.get_as_text()
	var splitted = content.split(" ",false)
	#(get_node("name") as RichTextLabel).text = content
	text = content
	if false:
		print(content)
	var position = Vector2(0, 0)
	var previous_symbol = null
	var index = 0
	for x in content:
		var clone = symbol_scene.instantiate()
		clone._previous_symbol = previous_symbol
		clone.index = index
		clone.function_parent = self
		clone.set_text(x)
		
		previous_symbol = clone
		var size = clone.get_size()
		

		if x == '\n':
			position.y += size.y
			position.x = 0
		
		if position.x > max_x:
			max_x = position.x
		
		if position.y > max_y:
			max_y = position.y

		clone.position = position
		position.x += size.x
		
		if false:
			print(clone.get_size())
		add_child(clone)
		index += 1
		

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
