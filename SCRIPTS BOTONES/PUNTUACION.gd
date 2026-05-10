extends Node

const SAVE_PATH = "user://scores.cfg"
var scores = {}

func _ready():
	load_scores()

func load_scores():
	var config = ConfigFile.new()
	var err = config.load(SAVE_PATH)
	if err != OK:
		return
	for game in config.get_sections():
		scores[game] = config.get_value(game, "best", 0)

func save_score(game: String, new_score: int, lower_is_better: bool = false):
	if not scores.has(game):
		scores[game] = new_score
	else:
		if lower_is_better:
			if new_score < scores[game]:
				scores[game] = new_score
		else:
			if new_score > scores[game]:
				scores[game] = new_score
	var config = ConfigFile.new()
	for g in scores:
		config.set_value(g, "best", scores[g])
	config.save(SAVE_PATH)

func get_score(game: String) -> int:
	return scores.get(game, 0)
