extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_former_pressed() -> void:
	get_tree().change_scene_to_file("res://former.tscn")


func _on_tal_pressed() -> void:
	get_tree().change_scene_to_file("res://tal.tscn")


func _on_dyr_pressed() -> void:
	get_tree().change_scene_to_file("res://Dyr.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_infoknap_pressed() -> void:
	get_tree().change_scene_to_file("res://infoskærm.tscn")
