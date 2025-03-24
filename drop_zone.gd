extends Marker2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _draw():
	draw_circle(Vector2.ZERO,75,Color.WHITE)
	modulate.a = 0.05

func select():
	for child in get_tree().get_nodes_in_group("zone"):
		child.deselect()
	modulate = Color.WEB_MAROON

	
func deselect():
	modulate = Color.WEB_MAROON
