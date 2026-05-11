extends Node
var score : int = 0
var lives : int = 3
var best_score : int = 0

func add_kill():
	score += 10
	if score > best_score:
		best_score = score
		Puntuacion.save_score("space_invaders", best_score)

func add_score(amount: int):
	score += amount

func lose_life():
	lives -= 1
	if lives <= 0:
		return true
	return false

func reset_game():
	score = 0
	lives = 3
