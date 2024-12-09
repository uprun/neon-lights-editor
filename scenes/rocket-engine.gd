extends Node2D

var next_position = null
var speed = 0

signal destination_reached

signal request_to_shift_position(shift)
signal request_to_set_position(another_position)

func _ready():
	next_position = get_parent().position

func _process(_delta):
	var current_position = get_parent().position
	if next_position != current_position:
		var diff = (current_position - next_position)
		var length = diff.length()
		if  length < 1:
			request_to_set_position.emit(next_position)
			speed = 0
			destination_reached.emit()
		else:
			if speed * 2 > length:
				speed = length * 0.8
			else:
				speed = (speed + 1) * 1.1
			var shift = -diff.normalized() * speed
			request_to_shift_position.emit(shift)

func position_changed():
	return next_position != get_parent().position

func update_position(new_position):
	next_position = new_position

func shift_position(delta: Vector2):
	next_position += delta
