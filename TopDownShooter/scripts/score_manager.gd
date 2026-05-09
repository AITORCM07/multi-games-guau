extends Node

var score : int = 0
var lives : int = 3

# Esta es la función que te faltaba y por eso daba error
func add_kill():
	score += 10 # Sumamos 10 puntos por cada enemigo muerto

func add_score(amount: int):
	score += amount

func lose_life():
	lives -= 1
	if lives <= 0:
		reset_game()
		return true
	return false

func reset_game():
	score = 0
	lives = 3
