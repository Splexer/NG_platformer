extends Node2D

@onready var win_area: Area2D = $Win_Area

func _on_win_area_body_entered(body: Node2D) -> void:
	if body is Player:
		#win_area.
		Events.game_win.emit()
