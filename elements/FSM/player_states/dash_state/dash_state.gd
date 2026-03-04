extends State


func enter()-> void:
	state_machine.transition_to("idle_state")
	
func exit()-> void:
	pass

func update(delta: float)-> void:
	pass

func physics_update(delta: float)-> void:
	pass
	
func handle_input(event: InputEvent)-> void:
	pass	
