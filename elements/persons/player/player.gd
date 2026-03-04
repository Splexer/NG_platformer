extends Person

class_name Player

@export var coyote_time : float = 1.0#0.16
@onready var coy_timer : Timer = $Coyote_timer


func _ready() -> void:
	coy_timer.wait_time = coyote_time
	super._ready()
	

func _unhandled_input(event: InputEvent) -> void:
	state_machine.handle_input(event)


#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
		#
	#var direction: float = 0.0
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = jump_force
	#if Input.is_action_pressed("walk_left"):
		#direction = -1.0
		#anim_sprite.flip_h = true
	#if	Input.is_action_pressed("walk_right"):
		#direction = 1.0
		#anim_sprite.flip_h = false
		#
	#if direction != 0.0:
		#velocity.x = direction * speed
		#anim_sprite.play("run")
	#else:
		#velocity.x = move_toward(velocity.x, 0, speed)
		#anim_sprite.play("idle")
#
	#move_and_slide()


func get_direction()-> float:
	return Input.get_axis("walk_left", "walk_right")
