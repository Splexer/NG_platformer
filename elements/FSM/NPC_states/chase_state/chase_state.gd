extends State


func enter()-> void:
	person.play_animation("chase")
	print("началась погоня")
	
func exit()-> void:
	pass

func update(delta: float)-> void:
	pass

func physics_update(delta: float)-> void:
	var npc: NPC = person as NPC
	if not npc:
		state_machine.transition_to("idle_state")
		return
	
	if not npc.is_on_floor():
		state_machine.transition_to("fall_state")
		return
	if not npc.target:
		state_machine.transition_to("patrol_state")
	
	var distance_to_target:float = npc.global_position.distance_to(npc.target.global_position)
	if distance_to_target > npc.visibility_range + 50:
		npc.target = null
		state_machine.transition_to("patrol_state")
		return
	
	var direction: float = sign(npc.target.global_position.x - npc.global_position.x)
	npc.set_direction(direction)
	
	var height_diff: float = abs(npc.target.global_position.y - npc.global_position.y)
	if height_diff >= 100:
		state_machine.transition_to("jump_state")
	
	if distance_to_target <= npc.attack_range:
		state_machine.transition_to("attack_state")
		
	npc.move_and_slide()
	
func handle_input(event: InputEvent)-> void:
	pass
