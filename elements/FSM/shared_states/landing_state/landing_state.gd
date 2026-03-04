extends State

const LANDING_TIME = 0.1

var _timer : float = 0.0

#По сути пока лишнее состояние в основном, только для анимации
#Но в перспективе сюда можно добавить урон от падения, удар об землю, эффекты и т.д.
func enter()-> void:
	person.play_animation("landing")
	_timer = LANDING_TIME
	
func exit()-> void:
	pass

func update(delta: float)-> void:
	pass

func physics_update(delta: float)-> void:
	person.move_and_slide()
	_timer -= delta
	if _timer <= 0:
		state_machine.transition_to("idle_state")
	
func handle_input(event: InputEvent)-> void:
	pass	
