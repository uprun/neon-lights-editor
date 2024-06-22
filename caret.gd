extends Node2D


func _draw():
	draw_line(Vector2(0, -10.0), Vector2(0, 10.0), Color.GREEN, 4.0)
	pass  # Your draw commands here.

var next_position: Vector2

func _process(_delta):
	if next_position != position:
		var diff = (position - next_position)
		if diff.length_squared() < 1:
			position = next_position
		else:
			position -= diff.normalized() #* _delta
	queue_redraw()

# Called when the node enters the scene tree for the first time.
func _ready():
	next_position = position
	pass # Replace with function body.
