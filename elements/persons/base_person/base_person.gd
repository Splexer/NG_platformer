extends CharacterBody2D

class_name Person

#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0

@export var HP : int = 1
@export var speed : float = 300.0
@export var damage : int = 1
@export var jump_force : float = -400.0

##Время неуязвимости после получения урона в секундах
@export var i_frames_time : float = 0.3


@onready var collision_shape : CollisionShape2D = $CollisionShape2D
@onready var anim_sprite : AnimatedSprite2D = $AnimatedSprite2D

##Функция получения урона. Безопасныое отключение коллизии, индикация цветом и проверка смерти
func _get_damage(damage : int)-> void:
	collision_shape.set_deferred("disabled", true)
	anim_sprite.modulate = Color(1.0, 0.2, 0.2)
	HP -= damage
	if HP <= 0:
		_die()
	else:
		await get_tree().create_timer(i_frames_time).timeout
		anim_sprite.modulate = Color(1.0, 1.0, 1.0)
		collision_shape.set_deferred("disabled", false)	
		
## Смэрть
func _die()-> void:
	print("я - ", self, " умэр. hp = ", HP)
	

#
#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
