extends State


func enter()-> void:
	if person is Player:
		person.can_coyote_jump = false
	person.velocity.y = person.jump_force
	person.play_animation("jump")


func physics_update(delta: float)-> void:
	person.velocity.y += Global.get_gravity() * delta
	var direction: float = person.get_direction()
	person.velocity.x = direction * person.speed
	person.update_look_direction(direction)
	person.move_and_slide()
	
	#Начали падать
	if person.velocity.y > 0:
		state_machine.transition_to("fall_state")
		return
	
	#Если над нами оказался потолок
	if person.is_on_floor():
		state_machine.transition_to("idle_state")
	
func handle_input(event: InputEvent)-> void:
	#Можно попробовать сделать силу прыжка зависимой от отпускания, если отпустить раньше
	#То быстрее упадёшь
	#if event.is_action_released("jump") and actor.velocity.y < 0:
		#actor.velocity.y *= 0.5
	pass


	
	
