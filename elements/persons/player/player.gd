extends Person

class_name Player

@export var coyote_time : float = 0.16

var can_coyote_jump : bool = false

@onready var coy_timer : Timer = $Coyote_timer
@onready var particles : GPUParticles2D = $GPUParticles2D


func _ready() -> void:
	coy_timer.wait_time = coyote_time
	super._ready()
	

func _unhandled_input(event: InputEvent) -> void:
	state_machine.handle_input(event)
	super._unhandled_input(event)

func get_damage(damage : int)-> void:
	call_deferred("set_collision_layer_value", 3, false)
	anim_sprite.modulate = Color(1.0, 0.2, 0.2)
	HP -= damage
	if HP <= 0:
		_die()
	else:
		await get_tree().create_timer(damage_immunity).timeout
		anim_sprite.modulate = Color(1.0, 1.0, 1.0)
		call_deferred("set_collision_layer_value", 3, true)

func get_direction()-> float:
	direction = Input.get_axis("walk_left", "walk_right")
	update_look_direction(direction)
	return direction
