extends Area2D

signal drop_event(dropped_object)

func _ready():
	set_input_pickable(true)  # Sørg for, at Area2D reagerer på musens input

# Når musen trykkes ned på boksen
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_LEFT:
			emit_signal("drop_event", shape_idx)  # Signal om at et objekt er droppet på denne boks

extends TextureRect

var original_texture: Texture2D
var original_position: Vector2
var has_been_dropped = false  # Sporer om billedet er droppet et sted
var valid_drop_area: Area2D = null  # Den boks, hvor dette billede kan placeres

# Bokseområder for hver af de 6 dyr
var drop_areas = {
	"Animal1": $Boks1,
	"Animal2": $Boks2,
	"Animal3": $Boks3,
	"Animal4": $Boks4,
	"Animal5": $Boks5,
	"Animal6": $Boks6,
}

# Navnet på dyret, der er blevet flyttet (skal matche boksen)
var animal_name = "Animal1"

func _ready():
	# Angiv hvilken boks dyret kan droppes i
	valid_drop_area = drop_areas[animal_name]
	original_texture = texture
	original_position = position

	# Connect signalet fra den korrekte Area2D
	valid_drop_area.connect("drop_event", self, "_on_drop_event")

func _get_drag_data(_at_position):
	if texture == null:
		return null  # Forhindrer at trække et tomt billede
	
	# Fjern teksturen fra den oprindelige TextureRect
	var dragged_texture = texture
	texture = null  
	has_been_dropped = false  # Nulstil status
	
	# Opret en forhåndsvisning af det trækkede billede
	var preview_texture = TextureRect.new()
	preview_texture.texture = dragged_texture
	preview_texture.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	preview_texture.size = Vector2(30, 30)
	
	var preview = Control.new()
	preview.add_child(preview_texture)
	
	set_drag_preview(preview)
	
	return dragged_texture

# Når dyret droppes på den rigtige boks
func _on_drop_event(shape_idx):
	if shape_idx == valid_drop_area.get_child_count() - 1:  # Tjek, om dyret droppes i den rette boks
		texture = original_texture
		position = valid_drop_area.position  # Placer dyret på boksen
		has_been_dropped = true
	else:
		has_been_dropped = false  # Hvis det ikke er korrekt, gendan det til oprindeligt sted
		position = original_position

# Hvis billedet ikke blev droppet et gyldigt sted, gendan det til sin oprindelige placering uden at påvirke andre billeder
func _notification(what):
	if what == NOTIFICATION_DRAG_END:
		if not has_been_dropped:
			texture = original_texture  # Gendan original tekstur
			position = original_position  # Flyt billedet tilbage til sin oprindelige placering
		has_been_dropped = false  # Nulstil flag
