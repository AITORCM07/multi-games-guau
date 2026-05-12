extends CanvasLayer
class_name UI
@onready var player_points_label = $MarginContainer/PlayerPoints
@onready var enemy_points_label = $MarginContainer/EnemyPoints

func _ready():
	player_points_label.text = "%d" % 0
	enemy_points_label.text = "%d" % 0

func update_enemy_points(points: int):
	enemy_points_label.text = "%d" % points

func update_player_point(points: int):
	player_points_label.text = "%d" % points

func show_winner(text: String):
	var label = Label.new()
	label.text = text
	label.add_theme_font_size_override("font_size", 64)
	label.add_theme_color_override("font_color", Color.YELLOW)
	label.set_anchors_preset(Control.PRESET_TOP_WIDE)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_TOP
	label.position.y = 80
	add_child(label)
