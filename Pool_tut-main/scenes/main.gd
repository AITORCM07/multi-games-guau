extends Node

@export var ball_scene : PackedScene

var ball_images := []
var cue_ball

const START_POS := Vector2(890, 340)
const MAX_POWER := 8.0
const MOVE_THRESHOLD := 5.0

var taking_shot : bool
var cue_ball_potted : bool
var potted := []

var lives : int
var shots : int

# 🎱 sistema bolas
var solids_potted := 0
var stripes_potted := 0

func _ready():
	load_images()
	new_game()
	$Table/Pockets.body_entered.connect(potted_ball)
	$Hud/ResultPanel/RestartButton.pressed.connect(new_game)
	$Cue.shoot.connect(_on_cue_shoot)

func load_images():
	for i in range(1, 17):
		var filename = "res://Pool_tut-main/assets/ball_" + str(i) + ".png"
		ball_images.append(load(filename))

func new_game():
	lives = 3
	shots = 0
	solids_potted = 0
	stripes_potted = 0

	$LivesLabel.text = "LIVES: " + str(lives)
	$ShotsLabel.text = "SHOTS: " + str(shots)

	cue_ball_potted = false

	clear_balls()
	generate_balls()
	reset_cue_ball()
	show_cue()

	get_tree().paused = false
	$Hud.hide()

func clear_balls():
	get_tree().call_group("balls", "queue_free")
	for b in potted:
		b.queue_free()
	potted.clear()

func generate_balls():
	var count : int = 0
	var rows : int = 5
	var dia = 36

	for col in range(5):
		for row in range(rows):
			var b = ball_scene.instantiate()
			var pos = Vector2(250 + (col * dia), 267 + (row * dia) + (col * dia / 2))
			add_child(b)
			b.position = pos

			b.get_node("Sprite2D").texture = ball_images[count]

			# guardar número de bola
			b.set_meta("ball_number", count + 1)

			count += 1
		rows -= 1

func remove_cue_ball():
	var old_b = cue_ball
	remove_child(old_b)
	old_b.queue_free()

func reset_cue_ball():
	cue_ball = ball_scene.instantiate()
	add_child(cue_ball)
	cue_ball.position = START_POS
	cue_ball.get_node("Sprite2D").texture = ball_images.back()
	taking_shot = false

func show_cue():
	$Cue.set_process(true)
	$Cue.position = cue_ball.position
	$PowerBar.position.x = cue_ball.position.x - (0.5 * $PowerBar.size.x)
	$PowerBar.position.y = cue_ball.position.y + $PowerBar.size.y
	$Cue.show()
	$PowerBar.show()

func hide_cue():
	$Cue.set_process(false)
	$Cue.hide()
	$PowerBar.hide()

func _process(_delta):
	var moving := false

	for b in get_tree().get_nodes_in_group("balls"):
		if b.linear_velocity.length() > 0.0 and b.linear_velocity.length() < MOVE_THRESHOLD:
			b.sleeping = true
		elif b.linear_velocity.length() >= MOVE_THRESHOLD:
			moving = true

	if not moving:
		if cue_ball_potted:
			reset_cue_ball()
			cue_ball_potted = false

		if not taking_shot:
			taking_shot = true
			show_cue()
	else:
		if taking_shot:
			taking_shot = false
			hide_cue()

func _on_cue_shoot(power):
	cue_ball.apply_central_impulse(power)
	shots += 1
	$ShotsLabel.text = "SHOTS: " + str(shots)

func potted_ball(body):
	# blanca
	if body == cue_ball:
		lives -= 1
		$LivesLabel.text = "LIVES: " + str(lives)
		cue_ball_potted = true
		remove_cue_ball()

		if lives == 0:
			game_over("lose")
		return

	var num = body.get_meta("ball_number")

	# bola negra
	if num == 8:
		if solids_potted == 7 or stripes_potted == 7:
			game_over("win")
		else:
			game_over("lose")
		return

	# lisas
	if num >= 1 and num <= 7:
		solids_potted += 1

	# rayadas
	elif num >= 9 and num <= 15:
		stripes_potted += 1

	# mostrar bolas metidas
	var b = Sprite2D.new()
	add_child(b)
	b.texture = body.get_node("Sprite2D").texture
	potted.append(b)
	b.position = Vector2(50 * potted.size(), 725)

	body.queue_free()

func game_over(outcome):
	hide_cue()
	get_tree().paused = true
	$Hud.show()

	if outcome == "win":
		$Hud/ResultPanel/ResultLabel.text = "YOU WIN!"
	else:
		$Hud/ResultPanel/ResultLabel.text = "GAME OVER!"

# 🎮 ESC PARA VOLVER AL MENÚ
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		go_to_menu()

func go_to_menu():
	get_tree().paused = false
	get_tree().root.content_scale_size = Vector2i(1920, 1080)
	get_tree().change_scene_to_file("res://SCENES/SELECION DE JUEGOS.tscn")

# 🔘 BOTÓN (por si lo usas en UI)
func _on_pressed() -> void:
	get_tree().root.content_scale_size = Vector2i(1920, 1080)
	get_tree().change_scene_to_file("res://SCENES/SELECION DE JUEGOS.tscn")
