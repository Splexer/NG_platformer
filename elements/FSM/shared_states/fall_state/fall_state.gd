extends State

func enter()-> void:
	if person is Player:
		if person.can_coyote_jump == true:
			person.coy_timer.start()
			
	person.play_animation("fall")

##Собсна падаем, если на полу, то переходим в landing, можно управлять в полёте
func physics_update(delta: float)-> void:
	person.velocity.y += Global.get_gravity() * delta
	
	var direction: float = person.get_direction()
	person.velocity.x = direction * person.speed
	person.update_look_direction(direction)
	person.move_and_slide()
	
	if person.is_on_floor():
		state_machine.transition_to("landing_state")
	
##Если мы игрок, то есть кайот тайм, и можно сделать удар в воздухе
func handle_input(event: InputEvent)-> void:
	var player: Player = person as Player 
	if not player:
		return
	if event.is_action_pressed("jump") and player.coy_timer.is_stopped() == false:
		state_machine.transition_to("jump_state")
	if event.is_action_pressed("attack"):
		state_machine.transition_to("attack_state")
