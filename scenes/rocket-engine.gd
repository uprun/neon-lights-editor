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
	else:
		var next = desired_locations.pop_front()
		if next != null:
			next_position = next

func position_changed():
	return next_position != get_parent().position


var desired_locations = []

func update_position(new_position):
	if new_position == get_parent().position:
		request_to_set_position.emit(new_position)
	else:
		var use_position = new_position
		var copy_y = use_position
		copy_y.y = get_parent().position.y
		var copy_x = use_position
		copy_x.x = get_parent().position.x
		var delta_y = copy_y - get_parent().position
		var delta_x = copy_x - get_parent().position
		if delta_x.length() < delta_y.length():
			desired_locations.push_back(copy_x)
			desired_locations.push_back(use_position)
		else:
			desired_locations.push_back(copy_y)
			desired_locations.push_back(use_position)
		next_position = desired_locations.pop_front()

func shift_position(delta: Vector2):
	next_position += delta
