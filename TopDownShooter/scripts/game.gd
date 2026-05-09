extends Node2D

@export var enemy_scene: PackedScene = preload("res://TopDownShooter/scenes/enemy.tscn")
@onready var player = $Player
@onready var score_label = $CanvasLayer/ScoreLabel
@onready var spawn_timer = $Timer

func _ready():
	# --- AJUSTE DE VELOCIDAD DE APARICIÓN ---
	# Empieza saliendo un grupo cada 0.5 segundos (muy rápido)
	spawn_timer.wait_time = 0.5 
	spawn_timer.start()

func _on_timer_timeout() -> void:
	if enemy_scene and player:
		# --- SPAWN MÚLTIPLE ---
		# En lugar de uno, vamos a spawnear 2 enemigos cada vez que el timer suene
		for i in range(2): 
			spawn_enemy()
		
		# --- DIFICULTAD EXTREMA ---
		# Cada vez el tiempo se reduce un poco más, hasta un mínimo de 0.2 segundos
		if spawn_timer.wait_time > 0.2:
			spawn_timer.wait_time -= 0.01

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	var spawn_pos = Vector2.ZERO
	
	# Buscar posición aleatoria que no esté pegada al jugador
	while true:
		spawn_pos.x = randf_range(0, get_viewport_rect().size.x)
		spawn_pos.y = randf_range(0, get_viewport_rect().size.y)
		if spawn_pos.distance_to(player.global_position) > 150:
			break
	
	enemy.global_position = spawn_pos
	add_child(enemy)

func _process(_delta):
	if is_instance_valid(score_label):
		# Actualizamos el marcador con puntos y vidas
		score_label.text = "PUNTUACION: %d | VIDAS: %d" % [ScoreManager.score, ScoreManager.lives]
