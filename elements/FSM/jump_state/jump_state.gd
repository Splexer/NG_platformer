extends Node

var person: Person
var state_machine: StateMachine


func enter()-> void:
	person.velocity.y = person.jump_force
	person.anim_sprite.play("jump")

func physics_update(delta: float)-> void:
	person.velocity.y += Global.get_gravity() * delta
	var direction: float = _get_direction()
	person.velocity.x = direction * person.speed * delta
	person.update_look_direction(direction)
	
	#Начали падать
	if person.velocity.y > 0:
		state_machine.transition_to("fall_state")
		return
	
	#Если над нами оказался потолок
	if person.is_on_floor():
		state_machine.transition_to("idle_state")
	
	person.move_and_slide()
	
func handle_input(event: InputEvent)-> void:
	#Можно попробовать сделать силу прыжка зависимой от отпускания, если отпустить раньше
	#То быстрее упадёшь
	#if event.is_action_released("jump") and actor.velocity.y < 0:
		#actor.velocity.y *= 0.5
	pass

func _get_direction()-> float:
	if person is Player:
		return Input.get_axis("walk_left", "walk_right")
		
	var npc: NPC = person as NPC
	if npc and npc.target != null:
		#Заглушка, но здесь надо, сделать, чтобы NPC прыгал в направление цели.
			return 1.0
	
	return 0.0
	
	
