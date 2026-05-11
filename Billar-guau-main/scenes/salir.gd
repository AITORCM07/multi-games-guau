extends Button
func _on_pressed() -> void:
	var main = get_tree().root.find_child("Main", true, false)
	if main:
		Puntuacion.save_score("billar", main.shots, true)
	get_tree().root.content_scale_size = Vector2i(1920, 1080)
	get_tree().change_scene_to_file("res://SCENES/SELECION DE JUEGOS.tscn")
