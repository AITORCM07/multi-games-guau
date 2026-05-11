extends Control

func _ready():
	$"SNAKE GUAU".text = str(Puntuacion.get_score("snake"))
	$"TETRIS GUAU".text = str(Puntuacion.get_score("tetris"))
	$"PLANE SHOOTER GUAU".text = str(Puntuacion.get_score("plane_shooter"))
	$"BILLAR GUAU".text = str(Puntuacion.get_score("billar"))
	$"DOGDE THE CREEPS GUAU".text = str(Puntuacion.get_score("dodge_the_creeps"))
	$"SPACE INVADERS GUAU".text = str(Puntuacion.get_score("space_invaders"))
