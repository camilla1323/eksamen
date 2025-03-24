extends Sprite2D

var dragging = false
var of = Vector2(0,0)

func _process(delta: float) -> void:
	if dragging:
		position = get_global_mouse_position() - of
		
		
func _on_button_button_down() -> void:
	dragging = true
	of = get_global_mouse_position() - global_position


func _on_button_button_up() -> void:
	dragging = false
	check_snap()
	

func check_snap():
	for area in get_tree().get_nodes_in_group("sort_cirkel"): # Skift til den rigtige gruppe
		if global_position.distance_to(area.global_position) < 80:  # Snap-afstand
			global_position = area.global_position
			return  # Stop efter første match
