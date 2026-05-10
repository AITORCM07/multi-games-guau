extends Node

func _on_snake_guau_pressed():
	get_tree().root.content_scale_size = Vector2i(1000, 1050)
	get_tree().change_scene_to_file("res://SNAKE GUAU/scenes/main.tscn")

func _on_tetris_guau_pressed():
	get_tree().root.content_scale_size = Vector2i(850, 750)
	get_tree().change_scene_to_file("res://tetris-guau-main/scenes/tile_map.tscn")

func _on_billar_guau_pressed():
	get_tree().root.content_scale_size = Vector2i(1200, 775)
	get_tree().change_scene_to_file("res://Billar-guau-main/scenes/main.tscn")

func _on_busca_mines_guau_pressed():
	get_tree().root.content_scale_size = Vector2i(750, 750)
	get_tree().change_scene_to_file("res://Busca-minas-guau-main/scenes/main.tscn")

func _on_pig_pong_guau_pressed() -> void:
	pass # Replace with function body.

func _on_space_inavders_guau_pressed() -> void:
	get_tree().change_scene_to_file("res://TopDownShooter/scenes/game.tscn")
	
func _on_volver_al_menu_principal_pressed() -> void:
	get_tree().change_scene_to_file("res://SCENES/menu.tscn")


func _on_plane_shooter_guau_pressed() -> void:
	get_tree().root.content_scale_size = Vector2i(860, 1500)
	get_tree().change_scene_to_file("res://PlaneShooter-master/Scenes/MainScene.tscn")


func _on_dodge_the_creeps_guau_pressed() -> void:
	get_tree().change_scene_to_file("res://dodge_the_creeps/Main.tscn")


func _on_puntuaciones_pressed() -> void:
	get_tree().change_scene_to_file("res://SCENES/Puntuaciones.tscn")
