extends Node

@export var snake_scene : PackedScene

var score : int
var game_started : bool = false

var cells_x : int = 20
var cells_y : int = 20
var cell_size : int = 50

var grid_offset : Vector2

var food_pos : Vector2
var regen_food : bool = true

var old_data : Array
var snake_data : Array
var snake : Array

var start_pos = Vector2(9, 9)
var up = Vector2(0, -1)
var down = Vector2(0, 1)
var left = Vector2(-1, 0)
var right = Vector2(1, 0)
var move_direction : Vector2
var can_move = true

func _ready() -> void:
	if not InputMap.has_action("move_up"):
		InputMap.add_action("move_up")
		var up_key = InputEventKey.new()
		up_key.keycode = KEY_UP
		InputMap.action_add_event("move_up", up_key)
		var w_key = InputEventKey.new()
		w_key.keycode = KEY_W
		InputMap.action_add_event("move_up", w_key)
	
	if not InputMap.has_action("move_down"):
		InputMap.add_action("move_down")
		var down_key = InputEventKey.new()
		down_key.keycode = KEY_DOWN
		InputMap.action_add_event("move_down", down_key)
		var s_key = InputEventKey.new()
		s_key.keycode = KEY_S
		InputMap.action_add_event("move_down", s_key)
	
	if not InputMap.has_action("move_left"):
		InputMap.add_action("move_left")
		var left_key = InputEventKey.new()
		left_key.keycode = KEY_LEFT
		InputMap.action_add_event("move_left", left_key)
		var a_key = InputEventKey.new()
		a_key.keycode = KEY_A
		InputMap.action_add_event("move_left", a_key)
	
	if not InputMap.has_action("move_right"):
		InputMap.add_action("move_right")
		var right_key = InputEventKey.new()
		right_key.keycode = KEY_RIGHT
		InputMap.action_add_event("move_right", right_key)
		var d_key = InputEventKey.new()
		d_key.keycode = KEY_D
		InputMap.action_add_event("move_right", d_key)
	
	grid_offset = Vector2(2, 50)
	new_game()

func new_game() -> void:
	get_tree().paused = false 
	get_tree().call_group("segments", "queue_free")
	$GameOverMenu.hide()
	score = 0
	$Hud.get_node("ScoreLabel").text = "PUNTUACION: " + str(score)
	move_direction = up 
	can_move = true 
	generate_snake()
	move_food()

func generate_snake():
	old_data.clear()
	snake_data.clear()
	snake.clear()
	for i in range(3):
		add_segment(start_pos + Vector2(0, i))
	snake[0].set_as_head()

func add_segment(pos):
	snake_data.append(pos)
	var SnakeSegment = snake_scene.instantiate()
	SnakeSegment.position = grid_offset + (pos * cell_size)
	SnakeSegment.size = Vector2(cell_size, cell_size)
	add_child(SnakeSegment)
	snake.append(SnakeSegment)

func _process(_delta):
	move_snake()

func move_snake():
	if can_move:
		if Input.is_action_just_pressed("move_down") and move_direction != up:
			move_direction = down
			can_move = false
			if not game_started:
				start_game()
		if Input.is_action_just_pressed("move_up") and move_direction != down:
			move_direction = up
			can_move = false
			if not game_started:
				start_game()
		if Input.is_action_just_pressed("move_left") and move_direction != right:
			move_direction = left
			can_move = false
			if not game_started:
				start_game()
		if Input.is_action_just_pressed("move_right") and move_direction != left:
			move_direction = right
			can_move = false
			if not game_started:
				start_game()

func start_game():
	game_started = true
	$MoveTimer.start()

func _on_move_timer_timeout():
	can_move = true
	old_data = [] + snake_data
	snake_data[0] += move_direction
	for i in range(len(snake_data)):
		if i > 0:
			snake_data[i] = old_data[i - 1]
		snake[i].position = grid_offset + (snake_data[i] * cell_size)
	check_out_of_bounds()
	check_self_eaten()
	check_food_eaten()

func check_out_of_bounds():
	if snake_data[0].x < 0 or snake_data[0].x >= cells_x or snake_data[0].y < 0 or snake_data[0].y >= cells_y:
		end_game()

func check_self_eaten():
	for i in range(1, len(snake_data)):
		if snake_data[0] == snake_data[i]:
			end_game()

func check_food_eaten():
	if snake_data[0] == food_pos:
		score += 1
		$Hud.get_node("ScoreLabel").text = "PUNTUACION: " + str(score)
		add_segment(old_data[-1])
		move_food()

func move_food():
	var valid_positions = []
	for x in range(0, cells_x):
		for y in range(0, cells_y):
			var pos = Vector2(x, y)
			if not snake_data.has(pos):
				valid_positions.append(pos)
	if valid_positions.size() > 0:
		food_pos = valid_positions[randi() % valid_positions.size()]
		$Food.position = grid_offset + (food_pos * cell_size)

func end_game():
	$GameOverMenu.show()
	$MoveTimer.stop()
	game_started = false
	get_tree().paused = true

func _on_game_over_menu_restart() -> void:
	new_game()
