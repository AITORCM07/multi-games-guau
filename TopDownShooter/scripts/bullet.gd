extends Area2D

var direction: Vector2
const SPEED = 600.0 # He subido la velocidad para que parezca una bala de verdad
var explosion_scene = preload("res://TopDownShooter/scenes/explosion.tscn")

func _physics_process(delta: float) -> void:
	# Añadimos 'delta' para que la velocidad sea constante sin importar los FPS
	global_position += direction * SPEED * delta

func _on_timer_timeout() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		# 1. Sumar puntos
		if ScoreManager.has_method("add_kill"):
			ScoreManager.add_kill()
		
		# 2. CREAR EXPLOSIÓN (Esto va ANTES de borrar la bala)
		if explosion_scene:
			var explosion = explosion_scene.instantiate()
			# Usamos get_tree().root para que la explosión no se borre al borrar la bala
			get_tree().root.add_child(explosion)
			explosion.global_position = global_position
			
			# Configurar partículas si el nodo tiene esas propiedades
			if "emitting" in explosion:
				explosion.emitting = true
			if "lifetime" in explosion:
				explosion.lifetime = randf_range(0.5, 0.7)
		
		# 3. Borrar enemigo
		body.queue_free()
		
		# 4. BORRAR LA BALA (Siempre al final)
		queue_free()
