extends Node

@export var snake_scene : PackedScene

#game variables
var score : int
var game_started : bool = false

#grid variables
var cells_x : int = 20 
var cells_y : int = 20
var cell_size : int = 50

var food_pos : Vector2
var regen_food : bool = true

#sanke variables
var old_data : Array
var snake_data :Array
var snake : Array

#movement variables
var start_pos = Vector2(9, 9)
var up = Vector2(0, -1)
var down = Vector2(0, 1)
var left = Vector2(-1, 0)
var right = Vector2(1, 0)
var move_direction : Vector2
var can_move = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()
	
func new_game() -> void:
	get_tree().paused = false 
	get_tree().call_group("segments" , "queue_free")
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
	SnakeSegment.position = (pos * cell_size) + Vector2(0, cell_size)
	add_child(SnakeSegment)
	snake.append(SnakeSegment)

func _process(_delta):
	move_snake()

func move_snake():
	if can_move:
		#update movement from keypresses
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
	#allow snake movement
	can_move = true
	#use the snake's previous position to move the segments
	old_data = [] + snake_data
	snake_data[0] += move_direction
	for i in range(len(snake_data)):
		#move all the segments along by one
		if i > 0:
			snake_data[i] = old_data[i - 1]
		snake[i].position = (snake_data[i] * cell_size) + Vector2(0, cell_size)
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
	#if snake eats the food, add a segment and move the food
	if snake_data[0] == food_pos:
		score += 1
		$Hud.get_node("ScoreLabel").text = "PUNTUACION: " + str(score)
		add_segment(old_data[-1])
		move_food()

func move_food():
	var valid_positions = []
	for x in range(1, cells_x - 1):
		for y in range(2, cells_y - 1):
			var pos = Vector2(x, y)
			if not snake_data.has(pos):
				valid_positions.append(pos)
	if valid_positions.size() > 0:
		food_pos = valid_positions[randi() % valid_positions.size()]
		$Food.position = (food_pos * cell_size) + Vector2(0, cell_size)
		
func end_game():
	$GameOverMenu.show()
	$MoveTimer.stop()
	game_started = false
	get_tree().paused = true
	

func _on_game_over_menu_restart() -> void:
	new_game()
