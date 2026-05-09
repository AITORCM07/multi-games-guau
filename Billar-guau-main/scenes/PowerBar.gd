extends ProgressBar

func _ready():
	pass

func _process(_delta):
	# Buscamos el nodo Cue y calculamos el porcentaje de potencia
	# usando la constante MAX_POWER definida en main.gd
	if get_parent() and "MAX_POWER" in get_parent():
		var cue_node = $"../Cue"
		if cue_node:
			value = cue_node.power * (100.0 / get_parent().MAX_POWER)
