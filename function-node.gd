extends Node2D

var symbol_scene = preload("res://symbol.tscn")
var text = ""

var folder_path = "/Users/almostfox/Documents/projects/WebPad/wwwroot/js/"
var file_name_1: String = "AddInformationToExistingOne.js"

func combined_path():
	return folder_path + file_name_1

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = FileAccess.open(combined_path(), FileAccess.READ)
	file.get
	var content = file.get_as_text()
	text = content
	for x in text:
		var clone = symbol_scene.instantiate()
		add_child(clone)
		clone.set_text(x)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
