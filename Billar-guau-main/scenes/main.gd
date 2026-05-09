extends Node

@export var ball_scene : PackedScene 

# Variables de juego
const MAX_POWER = 2000.0
const MOVE_THRESHOLD = 5.0
const START_POS = Vector2(890, 340)

var cue_ball
var lives : int = 3
var shots : int = 0
var taking_shot : bool = false
var cue_ball_potted : bool = false
var ball_images := []
var potted := []

func _ready():
	load_images()
	new_game()
	# Conectar la señal del taco
	if has_node("Cue"):
		$Cue.shoot.connect(_on_cue_shoot)

func _on_cue_shoot(force_vector: Vector2):
	if is_instance_valid(cue_ball):
		cue_ball.apply_central_impulse(force_vector)
		shots += 1
		update_hud()

func _process(_delta):
	var moving := false
	# Revisamos si alguna bola se está moviendo
	for b in get_tree().get_nodes_in_group("balls"):
		if b.linear_velocity.length() >= MOVE_THRESHOLD:
			moving = true
	
	if is_instance_valid(cue_ball) and cue_ball.linear_velocity.length() >= MOVE_THRESHOLD:
		moving = true

	if not moving:
		if cue_ball_potted:
			reset_cue_ball()
		if not taking_shot:
			show_cue_and_bar()
	else:
		if taking_shot:
			hide_cue_and_bar()

func new_game():
	lives = 3
	shots = 0
	clear_balls()
	generate_balls()
	reset_cue_ball()
	update_hud()

func generate_balls():
	var current_idx = 0
	var rows = 5
	var dia = 36
	for c in range(5):
		for r in range(rows):
			var b = ball_scene.instantiate()
			var pos = Vector2(250 + (c * dia), 267 + (r * dia) + (c * dia / 2.0))
			add_child(b)
			b.add_to_group("balls")
			b.position = pos
			if current_idx < ball_images.size():
				b.get_node("Sprite2D").texture = ball_images[current_idx]
			current_idx += 1
		rows -= 1

func reset_cue_ball():
	if is_instance_valid(cue_ball): cue_ball.queue_free()
	cue_ball = ball_scene.instantiate()
	add_child(cue_ball)
	cue_ball.position = START_POS
	if ball_images.size() >= 16:
		cue_ball.get_node("Sprite2D").texture = ball_images[15]
	cue_ball_potted = false

func show_cue_and_bar():
	taking_shot = true
	if has_node("Cue"):
		$Cue.show()
		$Cue.position = cue_ball.position
		$Cue.set_process(true)
	if has_node("PowerBar"): $PowerBar.show()

func hide_cue_and_bar():
	taking_shot = false
	if has_node("Cue"):
		$Cue.hide()
		$Cue.set_process(false)
	if has_node("PowerBar"): $PowerBar.hide()

func load_images():
	for k in range(1, 17):
		ball_images.append(load("res://Billar-guau-main/assets/ball_" + str(k) + ".png"))

func update_hud():
	if has_node("ShotsLabel"): $ShotsLabel.text = "SHOTS: " + str(shots)

func clear_balls():
	for b in get_tree().get_nodes_in_group("balls"): b.queue_free()
