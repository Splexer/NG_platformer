extends Person

class_name NPC

@export var visibility_range: float = 150

@onready var rays: Node2D = $Rays

@onready var ray_vision: RayCast2D = $Rays/RayCast_vision
@onready var ray_wall: RayCast2D = $Rays/RayCast_wall
@onready var ray_floor: RayCast2D = $Rays/RayCast_floor

@onready var direction_timer: Timer = $Direction_timer

var target: Player

func get_damage(damage : int)-> void:
	call_deferred("set_collision_layer_value", 4, false)
	_play_damage()
	anim_sprite.modulate = Color(1.0, 0.2, 0.2)
	HP -= damage
	if HP <= 0:
		_die()
	else:
		await get_tree().create_timer(damage_immunity).timeout
		call_deferred("set_collision_layer_value", 4, true)
		anim_sprite.modulate = Color(0.0, 1.0, 1.0, 1.0)
	
func _die()-> void:
	queue_free()		
