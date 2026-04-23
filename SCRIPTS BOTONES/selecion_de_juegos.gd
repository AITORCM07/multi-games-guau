extends Node

func _on_snake_guau_pressed():
	get_tree().change_scene_to_file("res://JUEGOS/SNAKE GUAU/scenes/main.tscn")

func _on_tetris_guau_pressed():
	get_tree().change_scene_to_file("res://JUEGOS/tetris-guau-main/scenes/tile_map.tscn")

func _on_space_invaders_guau_pressed():
	get_tree().change_scene_to_file("res://JUEGOS/TopDownShooter/scenes/game.tscn")

func _on_billar_guau_pressed():
	get_tree().change_scene_to_file("res://JUEGOS/Billar-guau-main/scenes/main.tscn")

func _on_busca_mines_guau_pressed():
	get_tree().change_scene_to_file("res://JUEGOS/Busca-minas-guau-main/scenes/main.tscn")
