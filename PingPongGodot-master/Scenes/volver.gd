extends Button

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	mouse_filter = Control.MOUSE_FILTER_STOP

func _on_pressed() -> void:
	get_tree().root.content_scale_size = Vector2i(1920, 1080)
	get_tree().change_scene_to_file("res://SCENES/SELECION DE JUEGOS.tscn")
