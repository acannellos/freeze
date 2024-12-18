class_name StateMachine
extends Node

var state = null:
	set = set_state
var previous_state = null

func _physics_process(delta: float) -> void:
	if state != null:
		_state_logic(delta)
		var transition = _get_transition()
		if transition != null:
			set_state(transition)

func _state_logic(delta: float) -> void:
	pass

func _get_transition():
	return null

func _enter_state(new_state) -> void:
	pass

func _exit_state(old_state) -> void:
	pass

func set_state(new_state) -> void:
	
	if new_state == state:
		return
	
	previous_state = state
	state = new_state
	
	if previous_state != null:
		_exit_state(previous_state)

	if new_state != null:
		_enter_state(new_state)
