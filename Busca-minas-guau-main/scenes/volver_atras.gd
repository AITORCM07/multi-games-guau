extends Button

func _on_pressed() -> void:
	get_tree().root.content_scale_size = Vector2i(1920, 1080)
	get_tree().change_scene_to_file("res://SCENES/SELECION DE JUEGOS.tscn")
