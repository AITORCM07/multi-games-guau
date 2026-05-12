extends RigidBody2D
class_name PaddlePingPong
@export var speed = 500

func _physics_process(_delta):
	var movement = Vector2.ZERO
	if Input.is_key_pressed(KEY_W):
		movement = Vector2.UP
	elif Input.is_key_pressed(KEY_S):
		movement = Vector2.DOWN
	
	linear_velocity = movement * speed
