extends Node

var score: int = 0
var time_elapsed: float = 0.0
var score_per_kill: int = 100

func _process(delta):
	time_elapsed += delta
	score += int(delta * 10)

func add_kill():
	score += score_per_kill

func reset():
	score = 0
	time_elapsed = 0.0
