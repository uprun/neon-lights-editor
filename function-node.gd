extends Node2D

var symbol_scene = preload("res://symbol.tscn")
var text = ""

var folder_path = "/Users/almostfox/Documents/projects/WebPad/wwwroot/js/"
var file_name_1: String = "AddInformationToExistingOne.js"

func combined_path():
	return folder_path + file_name_1
	
func populate_new_function(start_index, end_index):
	var name = text.substr( start_index, end_index - start_index + 1)
	print(name)
	self.get_parent().populate_new_function(name, max_x + position.x, position.y)

var max_x = 0
var max_y = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	var file = FileAccess.open(combined_path(), FileAccess.READ)
	file.get
	var content = file.get_as_text()
	text = content

var index = -1
var _position = Vector2(0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if index < text.length():
		index += 1
		var x = text.substr(index, 1)
		var clone = symbol_scene.instantiate()
		add_child(clone)
		clone.set_text(x)
		
		var size = clone.get_size()
		if x == '\n':
			_position.y += size.y
			_position.x = 0
		
		if _position.x > max_x:
			max_x = _position.x
		
		if _position.y > max_y:
			max_y = _position.y

		clone.position = _position
		_position.x += size.x
		
		
