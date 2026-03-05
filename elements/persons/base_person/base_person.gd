extends CharacterBody2D

class_name Person

#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0

@export var max_HP : int = 1
@export var HP : int = 1
@export var speed : float = 300.0
@export var damage : int = 1
@export var attack_range : float = 50
@export var attack_delay : float = 0.1
@export var jump_force : float = -400.0


@export var looking_to_the_right: bool = true

##Время неуязвимости после получения урона в секундах
@export var damage_immunity: float = 0.3

var direction : float = 1.0

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: StateMachine = $state_machine

func _ready()-> void:
	HP = max_HP
	state_machine.setup(self)

func _physics_process(delta: float)-> void:
	state_machine.physics_update(delta)
	
func _process(delta: float)-> void:
	state_machine.update(delta)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("check_states"):
		print("я ", self, " state = ", state_machine.current_state)

##Функция получения урона. Безопасныое отключение коллизии, индикация цветом и проверка смерти
func get_damage(damage : int)-> void:
	#collision_shape.set_deferred("disabled", true)
	anim_sprite.modulate = Color(1.0, 0.2, 0.2)
	HP -= damage
	if HP <= 0:
		_die()
	else:
		await get_tree().create_timer(damage_immunity).timeout
		anim_sprite.modulate = Color(1.0, 1.0, 1.0)
		#collision_shape.set_deferred("disabled", false)	
		
## Смэрть
func _die()-> void:
	print("я - ", self, " умэр. hp = ", HP)
	
func update_look_direction(direction: float)-> void:
	if direction < 0.0:
		anim_sprite.flip_h = true
	else:
		anim_sprite.flip_h = false

func play_animation(anim: String)-> void:
	if anim_sprite.sprite_frames.has_animation(anim):
		anim_sprite.play(anim)
	else:
		push_error("У персонажа ", self, " отсутствует анимация - ", anim)
		return	

func get_direction()-> float:
	return direction
	
func set_direction(new_direction: float)-> void:
	direction = new_direction
	update_look_direction(direction)
