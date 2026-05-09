extends CharacterBody2D

var bullet_scene = preload("res://TopDownShooter/scenes/bullet.tscn")
const SPEED = 300.0
var is_reloading = false
var dead = false 

func _physics_process(_delta: float) -> void:
	if dead: return 
	
	# 1. ROTACIÓN
	rotation = (get_global_mouse_position() - global_position).angle() + PI / 2
	
	# 2. MOVIMIENTO
	var direction = Vector2.ZERO
	if Input.is_key_pressed(KEY_W): direction.y -= 1
	if Input.is_key_pressed(KEY_S): direction.y += 1
	if Input.is_key_pressed(KEY_A): direction.x -= 1
	if Input.is_key_pressed(KEY_D): direction.x += 1
	
	velocity = direction.normalized() * SPEED
	move_and_slide()
	
	# 3. DISPARO
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if not is_reloading:
			shoot()
			start_shoot_timer()

	# 4. COLISIONES
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.is_in_group("enemies"):
			take_damage()

func shoot():
	if bullet_scene:
		var bullet = bullet_scene.instantiate()
		bullet.global_position = global_position + Vector2(0, -60).rotated(rotation)
		bullet.rotation = rotation - PI / 2
		if "direction" in bullet:
			bullet.direction = (get_global_mouse_position() - global_position).normalized()
		get_parent().add_child(bullet)

func start_shoot_timer():
	is_reloading = true
	await get_tree().create_timer(0.2).timeout 
	is_reloading = false

func take_damage():
	if dead: return
	dead = true
	
	# Llamamos al ScoreManager para restar una vida
	# La función lose_life() devuelve 'true' si las vidas llegan a 0
	ScoreManager.lose_life()
	
	var tree = get_tree()
	if tree != null:
		tree.reload_current_scene()

func _draw():
	# Diseño de la nave
	var body = PackedVector2Array([
		Vector2(0, -50), Vector2(30, 20), Vector2(16, 10),
		Vector2(-16, 10), Vector2(-30, 20),
	])
	draw_colored_polygon(body, Color("#00FFFF"))
	
	var cannon = PackedVector2Array([
		Vector2(0, -60), Vector2(8, -30), Vector2(-8, -30),
	])
	draw_colored_polygon(cannon, Color("#FF8C00"))
	
	draw_circle(Vector2(-8, -20), 6, Color.WHITE)
	draw_circle(Vector2(-8, -20), 3, Color("#00050F"))
	draw_circle(Vector2(8, -20), 6, Color.WHITE)
	draw_circle(Vector2(8, -20), 3, Color("#00050F"))
	draw_line(Vector2(-12, -8), Vector2(12, -8), Color.WHITE, 2.5)

func _ready():
	dead = false
	queue_redraw()
