extends Person

class_name NPC

func _ready() -> void:
	pass

func get_direction()-> float:
	direction = 1.0
	#Заглушка, но здесь надо, сделать, чтобы NPC поворачивал в направление цели или куда-то ещё.
	return 1.0
