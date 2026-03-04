extends Node

class_name StateMachine

@export var initial_state: State

var current_state: State

func setup(person: Person) -> void:
	#Это мы всем состояниям дочерним инициализируем персонажа
	for child in get_children():
		child.person = person
		child.state_machine = self
	current_state = initial_state
	current_state.enter()

func transition_to(new_state_name: String)-> void:
	var new_state = get_node(new_state_name)
	if new_state == current_state:
		return
	current_state.exit()
	current_state = new_state as State
	current_state.enter()
		
func update(delta: float)-> void:
	if current_state != null:
		current_state.update(delta) 
	
		
func physics_update(delta: float)-> void:
	if current_state != null:
		current_state.physics_update(delta)

	
func handle_input(event: InputEvent)-> void:
	if current_state != null:
		current_state.handle_input(event)
	
	
