extends Node2D

var next_position = null
var speed = 0

signal destination_reached

func _ready():
	next_position = get_parent().position

func _process(_delta):
	var parent = get_parent()
	if next_position != parent.position:
		var diff = (parent.position - next_position)
		var length = diff.length()
		if  length < 1:
			parent.position = next_position
			speed = 0
			destination_reached.emit()
		else:
			if speed * 2 > length:
				speed = length * 0.8
			else:
				speed = (speed + 1) * 1.1
			parent.position -= diff.normalized() * speed

func position_changed():
	return next_position != get_parent().position

func update_position(new_position):
	next_position = new_position

func shift_position(delta: Vector2):
	next_position += delta
