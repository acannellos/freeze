class_name PlayerMoveState
extends PlayerState

# TODO add stunned

enum States {IDLE, RUNNING, SPRINTING}
var nen_multiplier: float = 1.0

func _ready():
	call_deferred("set_state", States.IDLE)

func calculate_final_speed() -> void:
	match state:
		States.IDLE:
			player.move_component.set_speed(player.movement.get_base_speed() * nen_multiplier)
		States.RUNNING:
			player.move_component.set_speed(player.movement.get_base_speed() * nen_multiplier)
		States.SPRINTING:
			player.move_component.set_speed(player.movement.get_sprint_speed() * nen_multiplier)

func _get_transition():
	if player.move_component.input_dir:
		if player.move_component.input_sprint:
			return States.SPRINTING
		return States.RUNNING
	return States.IDLE

func _enter_state(new_state):
	Events.player_move_state_changed.emit(new_state)
	
	match new_state:
		States.IDLE:
			player.move_component.set_speed(player.movement.get_base_speed() * nen_multiplier)
		States.RUNNING:
			player.move_component.set_speed(player.movement.get_base_speed() * nen_multiplier)
		States.SPRINTING:
			player.move_component.set_speed(player.movement.get_sprint_speed() * nen_multiplier)

func _state_logic(delta: float) -> void:
	match state:
		States.IDLE:
			player.head.lerp_fov_to(75)
		States.RUNNING:
			player.head.lerp_fov_to(80)
		States.SPRINTING:
			player.head.lerp_fov_to(85)
