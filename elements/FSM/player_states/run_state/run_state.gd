extends State


func enter()-> void:
	person.play_animation("run")
	
	
func exit()-> void:
	pass

func update(delta: float)-> void:
	pass

func physics_update(delta: float)-> void:
	var direction: float = person.get_direction()
	person.velocity.x = direction * person.speed
	person.move_and_slide()
	
	if not person.is_on_floor():
		state_machine.transition_to("fall_state")
		return
	if person.velocity.x == 0.0:
		state_machine.transition_to("idle_state")	
	
func handle_input(event: InputEvent)-> void:
	if event.is_action_pressed("jump"):
		state_machine.transition_to("jump_state")
	if event.is_action_pressed("attack"):
		state_machine.transition_to("attack_state")
	if event.is_action_pressed("dash"):
		state_machine.transition_to("dash_state")
