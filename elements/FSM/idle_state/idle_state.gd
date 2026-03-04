extends State


func enter()-> void:
	person.velocity.x = 0
	person.anim_sprite.play("idle")

func update(delta: float)-> void:
	pass

## Обработка нажатий для перехода к движению, перехода к падению и патрулированию/погоне у NPC
func physics_update(delta: float)-> void:
	if not person.is_on_floor():
		state_machine.transition_to("fall_state")
		return
		
	var npc: NPC = person as NPC
	if npc:
		if npc.target and npc.global_position.distance_to(npc.target.global_position) <= npc.detection_radius:
			state_machine.transition_to("сhase_state")
		elif not npc.patrol_points.is_empty():
			state_machine.transition_to("patrol_state")
			
	if person is Player:
		if Input.get_axis("walk_left", "walk_right") != 0.0:
			state_machine.transition_to("run_state")
		#if Input.is_action_just_pressed("jump"):
			#state_machine.transition_to("jump_state")
	
	person.move_and_slide()	

##Обработка нажатий, должна вызываться только объектом класса Player
func handle_input(event: InputEvent) -> void:
	if not person is Player:
		return
	if event.is_action_just_pressed("jump"):
		state_machine.transition_to("jump_state")
	if event.is_action_just_pressed("attack"):
		state_machine.transition_to("attack_state")
	if event.is_action_just_pressed("dash") and person.dash_cooldown_timer.is_stopped():
		state_machine.transition_to("dash_state")
