extends Node

var gravity : float

func _ready() -> void:
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func get_gravity()-> float:
	return gravity

func set_gravity(new_gravity: float)-> void:
	gravity = new_gravity	
