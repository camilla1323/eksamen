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
	
func get_form_type():
	return "firkant"  # Skift i andre formers scripts

func snap_to_position(target_position):
	global_position = target_position
