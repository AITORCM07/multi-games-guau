extends CharacterBody2D

# Velocidad aumentada para que la horda sea rápida
const SPEED = 100.0 

func _physics_process(_delta: float) -> void:
	# Buscamos al jugador en la escena de forma segura
	var player = get_tree().root.find_child("Player", true, false)
	
	if player:
		# 1. DIRECCIÓN HACIA EL JUGADOR
		var target_position = player.global_position
		var direction = (target_position - global_position).normalized()
		
		# 2. ROTACIÓN PARA MIRAR AL JUGADOR
		look_at(target_position)
		
		# 3. MOVIMIENTO
		velocity = direction * SPEED
		
		# 4. EVITAR QUE SE AMONTONEN (Separación)
		# Si el enemigo choca con otro, move_and_slide lo manejará, 
		# pero con CharacterBody2D y una colisión circular se deslizarán mejor.
		move_and_slide()
	else:
		# Si el jugador muere, los enemigos se detienen
		velocity = Vector2.ZERO
