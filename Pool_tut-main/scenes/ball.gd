extends RigidBody2D

func _ready():
	# 🔥 quitar gravedad (clave para billar)
	gravity_scale = 0

	# 🔥 asegurarse de que está en el grupo
	if not is_in_group("balls"):
		add_to_group("balls")

	# 🔥 opcional: un poco de fricción para que no se deslicen eternamente
	linear_damp = 0.8
	angular_damp = 1.0
