extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_startskærm_knap_pressed() -> void:
	print("Info button was pressed!")  # Debugging message
	get_tree().change_scene_to_file("res://startskærm.tscn")


func _on_spil_igen_knap_pressed() -> void:
	print("Info button was pressed!")  # Debugging message
	get_tree().change_scene_to_file("res://former.tscn")
