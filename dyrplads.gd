extends Area2D

@export var accepted_animal: String  # Den figur der passer her

func _on_area_entered(area):
	if area is Area2D and area.name == accepted_animal:
		print("Korrekt figur placeret:", area.name)
