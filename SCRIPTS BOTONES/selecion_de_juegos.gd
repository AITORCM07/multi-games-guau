extends Node

func _on_snake_guau_pressed():
	DisplayServer.window_set_size(Vector2i(1004, 1082))
	DisplayServer.window_set_position(Vector2i(100, 50))
	get_tree().change_scene_to_file("res://SNAKE GUAU/scenes/main.tscn")

func _on_tetris_guau_pressed():
	DisplayServer.window_set_size(Vector2i(850, 750))
	DisplayServer.window_set_position(Vector2i(200, 50))
	get_tree().root.content_scale_size = Vector2i(850, 750)
	get_tree().change_scene_to_file("res://tetris-guau-main/scenes/tile_map.tscn")

func _on_billar_guau_pressed():
	get_tree().change_scene_to_file("res://Billar-guau-main/scenes/main.tscn")

func _on_busca_mines_guau_pressed():
	get_tree().change_scene_to_file("res://Busca-minas-guau-main/scenes/main.tscn")

func _on_pig_pong_guau_pressed() -> void:
	pass # Replace with function body.

func _on_space_inavders_guau_pressed() -> void:
	get_tree().change_scene_to_file("res://TopDownShooter/scenes/game.tscn")
	
func _on_volver_al_menu_principal_pressed() -> void:
	get_tree().change_scene_to_file("res://SCENES/menu.tscn")
