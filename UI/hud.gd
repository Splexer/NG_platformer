extends CanvasLayer

@onready var hp_label: Label = $MarginContainer/HP_box/HP_actual_label
@onready var hp_max_label : Label = $MarginContainer/HP_box/HP_max_label

@onready var end_color_rect : ColorRect = $ColorRect
@onready var win_text: Label = $ColorRect/Win_label
@onready var game_over_text: Label = $ColorRect/Game_over_label



func _ready() -> void:
	Events.player_hp_update.connect(_update_hp_bar)
	Events.game_over.connect(_game_over)
	Events.game_win.connect(_game_win)

func _update_hp_bar(hp: int, max_hp: int)-> void:
	hp_label.text = str(hp)
	hp_max_label.text = "/" + str(max_hp)

func _game_over()-> void:
	win_text.hide()
	game_over_text.show()
	var tween = create_tween()
	tween.tween_property(end_color_rect, "modulate:a", 1.0, 4)
	await tween.finished
	Global.exit_game()
	
func _game_win()-> void:
	win_text.show()
	game_over_text.hide()
	var tween = create_tween()
	tween.tween_property(end_color_rect, "modulate:a", 1.0, 4)
	await tween.finished
	Global.exit_game()
	
