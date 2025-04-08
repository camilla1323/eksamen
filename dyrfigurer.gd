extends Area2D

@export var correct_box: NodePath  # Fx "../Plads"
var start_position: Vector2
var dragging := false

@onready var feedback_label: Label = $FeedbackLabel

func _ready():
	start_position = global_position
	feedback_label.text = ""

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Tjek om musen klikker på denne figur
				var space_state = get_world_2d().direct_space_state
				var query = PhysicsPointQueryParameters2D.new()
				query.position = get_global_mouse_position()
				query.collide_with_areas = true
				var results = space_state.intersect_point(query)

				for result in results:
					if result.collider == self:
						dragging = true
						break
			else:
				# Musen er sluppet – stop med at trække og tjek placering
				if dragging:
					dragging = false
					check_placement()

	elif event is InputEventMouseMotion and dragging:
		global_position = get_global_mouse_position()

func check_placement():
	if correct_box == null or correct_box.is_empty():
		feedback_label.text = "❌ Mangler korrekt målområde!"
		return

	var box = get_node(correct_box)
	if not box:
		feedback_label.text = "❌ Kunne ikke finde boksen!"
		return

	if box is Area2D and box.get_overlapping_areas().has(self):
		global_position = box.global_position
		feedback_label.text = "✅ Korrekt!"
	else:
		global_position = start_position
		feedback_label.text = "❌ Forkert placering!"
