extends State

func enter()-> void:
	var ray_shot_result : Dictionary = {}
	if person is Player:
		ray_shot_result = _shot_ray_and_get_collider(8)
		var attack_pool: Array[String] = ["attack", "attack_2", "attack_3"]
		person.play_animation(attack_pool.pick_random())
	else:
		ray_shot_result =_shot_ray_and_get_collider(4)
		person.play_animation("attack")
	if not ray_shot_result.is_empty():
		var collider: Object = ray_shot_result.get("collider")
		if collider.has_method("get_damage"):
			collider.get_damage(person.damage)
	await get_tree().create_timer(person.attack_delay).timeout
	state_machine.transition_to("idle_state")
		
		
func exit()-> void:
	pass

func update(delta: float)-> void:
	pass

func physics_update(delta: float)-> void:
	pass
	
func handle_input(event: InputEvent)-> void:
	pass	


func _shot_ray_and_get_collider(collision_mask: int)-> Dictionary:
	var space_state: PhysicsDirectSpaceState2D = person.get_world_2d().direct_space_state
	if person.get_direction() >= 0.0:
		person.set_direction(1.0)
	else:
		person.set_direction(1.0)
	if person is NPC:
		person.set_direction(sign(person.target.global_position.x - person.global_position.x))
		
	var query = PhysicsRayQueryParameters2D.create(person.global_position, \
	person.global_position + \
	Vector2(person.get_direction() * person.attack_range, 0), collision_mask)
	var result: Dictionary = space_state.intersect_ray(query)
	return result
	
	
	
	
	
		
