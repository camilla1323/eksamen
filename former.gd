extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_tilbage_knap_pressed() -> void:
	get_tree().change_scene_to_file("res://startskærm.tscn")


func _on_hjælp_knap_pressed() -> void:
	get_tree().change_scene_to_file("res://hjælpskærm_former.tscn")
