class_name PlayerGroundState
extends PlayerState

enum States {GROUNDED, INAIR}
var nen_multiplier: float = 1.0

func _ready():
	call_deferred("set_state", States.GROUNDED)

func calculate_final_acceleration() -> void:
	match state:
		States.GROUNDED:
			player.move_component.set_acceleration(player.movement.get_base_acceleration() * nen_multiplier)
		States.INAIR:
			player.move_component.set_acceleration(player.movement.get_air_acceleration() * nen_multiplier)
			
func _get_transition():
	if player.is_on_floor():
		return States.GROUNDED
	return States.INAIR

func _enter_state(new_state):
	Events.player_ground_state_changed.emit(new_state)
	
	match new_state:
		States.GROUNDED:
			player.move_component.set_acceleration(player.movement.get_base_acceleration() * nen_multiplier)
		States.INAIR:
			player.move_component.set_acceleration(player.movement.get_air_acceleration() * nen_multiplier)
