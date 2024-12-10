extends Node2D

var next_position = null
var speed = 0

signal destination_reached

signal request_to_shift_position(shift)
signal request_to_set_position(another_position)

func _ready():
	next_position = get_parent().position

func get_destination_location():
	var final = desired_locations.back()
	if final == null:
		return next_position
	else:
		return final

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
	return get_destination_location() != get_parent().position


var desired_locations = []

func update_position(new_position):
	if new_position == get_parent().position:
		request_to_set_position.emit(new_position)
	else:
		var current_parent_position = get_parent().position
		var use_position = new_position
		var copy_y = use_position
		copy_y.y = current_parent_position.y
		var copy_x = use_position
		copy_x.x = current_parent_position.x
		var delta_y = copy_y - current_parent_position
		var delta_x = copy_x - current_parent_position
		if delta_x.length() < delta_y.length() or delta_y.length() < 1.0:
			desired_locations.push_back(copy_x)
			desired_locations.push_back(use_position)
		else:
			desired_locations.push_back(copy_y)
			desired_locations.push_back(use_position)
		next_position = desired_locations.pop_front()

func shift_position(delta: Vector2):
	update_position( next_position + delta)
