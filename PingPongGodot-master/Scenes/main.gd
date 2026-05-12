extends Node2D
var player_points = 0
var enemy_points = 0
var game_over = false
@onready var enemy_paddle = $EnemyPaddlePingPong
@onready var player_paddle = $PaddlePingPong
@onready var ball = $BallPingPong
@onready var UI = $UIPingPong

func _process(_delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().root.content_scale_size = Vector2i(1920, 1080)
		get_tree().change_scene_to_file("res://SCENES/SELECION DE JUEGOS.tscn")

func enemy_scored():
	enemy_points += 1
	UI.update_enemy_points(enemy_points)
	if enemy_points >= 7:
		UI.show_winner("¡JUGADOR 2 GANA!\nPulsa ESC para salir")
		return
	reset_game_state()

func player_scored():
	player_points += 1
	UI.update_player_point(player_points)
	if player_points >= 7:
		UI.show_winner("¡JUGADOR 1 GANA!\nPulsa ESC para salir")
		return
	reset_game_state()

func reset_game_state():
	enemy_paddle.global_position.y = 0
	player_paddle.global_position.y = 0
	ball.velocity = Vector2.ZERO
	enemy_paddle.linear_velocity = Vector2.ZERO
	player_paddle.linear_velocity = Vector2.ZERO
	ball.global_position = Vector2.ZERO
	ball.start_ball()
