extends State


func enter()-> void:
	var npc: NPC = person as NPC
	if not npc:
		state_machine.transition_to("idle_state")
		return
	person.play_animation("run")
	person.set_direction(1.0)
	person.rays.scale.x = 1
	
	
func exit()-> void:
	pass

func update(delta: float)-> void:
	pass

func physics_update(delta: float)-> void:
	var npc: NPC = person as NPC
	if not npc:
		state_machine.transition_to("idle_state")
		return
	if not person.is_on_floor():
		state_machine.transition_to("fall_state")

	if _no_floor_in_front() == true or _near_wall() == true:
		person.set_direction(person.get_direction() * -1)
		person.rays.scale.x *= -1
		

	person.velocity.x = person.get_direction() * person.speed	
	person.move_and_slide()
	
	if _target_lock(npc):
		state_machine.transition_to("chase_state")
		return
		
		
		

func _target_lock(npc: NPC)-> bool:
	var collider = npc.ray_vision.get_collider()
	if collider is Player:
		npc.target = collider
		return true
	else:
		npc.target = null
		return false
	
func _near_wall()-> bool:
	#person.ray_wall.target_position.x *= person.get_direction() 
	var was_collider = person.ray_wall.is_colliding()
	if was_collider == true:
		return true
	else:
		return false	
	#var space_state: PhysicsDirectSpaceState2D = person.get_world_2d().direct_space_state
	#var target_position: Vector2 = person.global_position + Vector2(30, 0) * person.get_direction()
	#var query = PhysicsRayQueryParameters2D.create(person.global_position, target_position, 2)
	#var result: Dictionary = space_state.intersect_ray(query)
	#return not result.is_empty()
		
func _no_floor_in_front()-> bool:
	#person.ray_floor.position.x *= person.get_direction() 
	var collider = person.ray_floor.is_colliding()
	if collider == true:
		return false
	else:
		return true

func handle_input(event: InputEvent)-> void:
	pass
