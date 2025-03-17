extends CharacterBody2D

var dragging = false

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and get_global_mouse_position().distance_to(position) < 30:
			dragging = true
		elif not event.pressed:
			dragging = false

func _process(delta):
	if dragging:
		position = get_global_mouse_position()
