extends Area2D

@export var correct_box: NodePath  # Reference til den korrekte boks
var start_position: Vector2  # Gemmer startpositionen
var dragging: bool = false  # Om figuren bliver trukket
@onready var feedback_label = $FeedbackLabel  # Henter Label-node

func _ready():
	start_position = global_position  # Husker startpositionen
	feedback_label.text = ""  # Start med tom tekst

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and is_mouse_over():  # Klik på figuren
			dragging = true
		elif !event.pressed:  # Musen slippes
			dragging = false
			check_placement()

	if event is InputEventMouseMotion and dragging:
		global_position = get_viewport().get_mouse_position()  # Flyt figuren til musens position

func is_mouse_over() -> bool:
	var space_state = get_world_2d().direct_space_state
	var mouse_pos = get_viewport().get_mouse_position()
	var query = PhysicsPointQueryParameters2D.new()
	query.position = mouse_pos
	query.collision_mask = collision_layer  # Sørger for, at vi tjekker det rigtige lag

	var result = space_state.intersect_point(query)
	for r in result:
		if r.collider == self:
			return true
	return false

func check_placement():
	if correct_box == null or correct_box.is_empty():
		feedback_label.text = "❌ Fejl: Mangler correct_box!"
		return

	var correct_boks = get_node(correct_box)
	if not correct_boks:
		feedback_label.text = "❌ Fejl: Kan ikke finde boksen!"
		return

	if correct_boks.get_overlapping_areas().has(self):
		global_position = correct_boks.global_position  # Snap til korrekt placering
		feedback_label.text = "✅ Korrekt placering!"
	else:
		global_position = start_position  # Gå tilbage til start hvis forkert
		feedback_label.text = "❌ Forkert placering, prøv igen!"
