extends CharacterBody2D
class_name BallPingPong
@export var INITIAL_BALL_SPEED = 900
@onready var audio_stream_player = $AudioStreamPlayer
@export var speed_multiplier = 1.1
var ball_speed = 900

func _ready():
	start_ball()

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		if collision.get_collider() is Paddle:
			ball_speed *= speed_multiplier
			audio_stream_player.play()

func start_ball():
	ball_speed = INITIAL_BALL_SPEED
	randomize()
	velocity.x = [-1, 1][randi() % 2] * ball_speed
	velocity.y = [-0.8, 0.8][randi() % 2] * ball_speed
