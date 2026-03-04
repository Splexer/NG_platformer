extends Node

class_name State

var person: Person
var state_machine: StateMachine

func enter()-> void:
	person.anim_sprite.play("fall")

##Собсна падаем, если на полу, то переходим в landing, можно управлять в полёте
func physics_update(delta: float)-> void:
	person.velocity.y += Global.get_gravity() * delta
	
	var direction: float = _get_direction()
	person.velocity.x = direction * person.speed * delta
	person.update_look_direction(direction)
	
	person.move_and_slide()
	
	if person.is_on_floor():
		state_machine.transition_to("landing_state")
	
##Если мы игрок, то есть кайот тайм, и можно сделать удар в воздухе
func handle_input(event: InputEvent)-> void:
	var player: Player = person as Player
	if !player:
		return
	if event.is_action_just_pressed("jump") and !player.coy_timer.is_stopped():
		state_machine.transition_to("jump_state")
	if event.is_action_just_pressed("attack"):
		state_machine.transition_to("attack_state")

#Как и везде, получаем направление, возможно стоит вынести в person, ибо уже несколько раз повторил
func _get_direction()-> float:
	if person is Player:
		return Input.get_axis("walk_left", "walk_right")
		
	var npc: NPC = person as NPC
	if npc and npc.target != null:
		#Заглушка, но здесь надо, сделать, чтобы NPC прыгал в направление цели.
			return 1.0
	
	return 0.0
