extends RigidBody2D
const SPEED = 800

func _physics_process(_delta):
	var direction = 0
	if Input.is_key_pressed(KEY_UP):
		direction = -1
	elif Input.is_key_pressed(KEY_DOWN):
		direction = 1
	linear_velocity.y = direction * SPEED
