extends ProgressBar

func _process(_delta):
	value = $"../Cue".power * (100.0 / get_parent().MAX_POWER)
