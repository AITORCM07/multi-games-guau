extends Panel

var is_head : bool = false

func set_as_head():
	is_head = true
	queue_redraw()

func _draw():
	if is_head:
		# ulls blancs
		draw_circle(Vector2(12, 14), 5, Color.WHITE)
		draw_circle(Vector2(38, 14), 5, Color.WHITE)
		# pupil·les negres
		draw_circle(Vector2(12, 14), 3, Color.BLACK)
		draw_circle(Vector2(38, 14), 3, Color.BLACK)
		# llengua roja
		draw_line(Vector2(25, 45), Vector2(20, 55), Color.RED, 2)
		draw_line(Vector2(25, 45), Vector2(30, 55), Color.RED, 2)
