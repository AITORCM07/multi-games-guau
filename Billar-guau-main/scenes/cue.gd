extends Sprite2D

signal shoot(force: Vector2)

var power : float = 0.0
var power_dir : int = 1

func _process(_delta):
	# Rotar el taco hacia el ratón
	var mouse_pos := get_global_mouse_position()
	look_at(mouse_pos)
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		# Cargamos potencia usando el MAX_POWER del padre
		var max_p = get_parent().MAX_POWER if "MAX_POWER" in get_parent() else 2000.0
		power += 15.0 * power_dir
		if power >= max_p:
			power_dir = -1
		elif power <= 0:
			power_dir = 1
	else:
		power_dir = 1
		if power > 0:
			# Calculamos dirección y disparamos
			var dir = (get_global_mouse_position() - global_position).normalized()
			shoot.emit(dir * power)
			power = 0.0
