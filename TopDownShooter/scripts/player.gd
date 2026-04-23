extends CharacterBody2D

var bullet_scene = preload("res://scenes/bullet.tscn")
const SPEED = 200
@onready var is_reloading = false

func _physics_process(delta: float) -> void:
	rotation = (get_global_mouse_position() - global_position).angle() + PI / 2
	
	velocity.x = Input.get_axis("left", "right") * SPEED
	velocity.y = Input.get_axis("up", "down") * SPEED
	velocity = lerp(get_real_velocity(), velocity, 0.1)
	
	if Input.is_action_just_pressed("shoot"):
		var bullet = bullet_scene.instantiate()
		bullet.global_position = global_position + transform.y * -60
		bullet.direction = (get_global_mouse_position() - global_position).normalized()
		$/root/Game.add_child(bullet)
	
	move_and_slide()
	
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		
		if collision.get_collider().is_in_group("enemies") and not is_reloading:
			is_reloading = true
			ScoreManager.reset()
			get_tree().reload_current_scene()

func _draw():
	# Nave (azul)
	var body = PackedVector2Array([
		Vector2(0, -50),
		Vector2(30, 20),
		Vector2(16, 10),
		Vector2(-16, 10),
		Vector2(-30, 20),
	])
	draw_colored_polygon(body, Color("#00FFFF"))
	
	# Cañón (naranja)
	var cannon = PackedVector2Array([
		Vector2(0, -60),
		Vector2(8, -30),
		Vector2(-8, -30),
	])
	draw_colored_polygon(cannon, Color("#FF8C00"))
	
	# Ojo izquierdo
	draw_circle(Vector2(-8, -20), 6, Color.WHITE)
	draw_circle(Vector2(-8, -20), 3, Color("#00050F"))
	
	# Ojo derecho
	draw_circle(Vector2(8, -20), 6, Color.WHITE)
	draw_circle(Vector2(8, -20), 3, Color("#00050F"))
	
	# Boca
	draw_line(Vector2(-12, -8), Vector2(12, -8), Color.WHITE, 2.5)

func _ready():
	queue_redraw()
