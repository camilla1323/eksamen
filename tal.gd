extends Node

func start():
	pass


func _on_tilbage_knap_pressed() -> void:
	get_tree().change_scene_to_file("res://startskærm.tscn")
