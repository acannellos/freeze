extends Node

signal player_connected(player: Player)
signal player_sprinted
signal player_jumped(jump_cost: float)

signal player_move_state_changed(new_state)
signal player_ground_state_changed(new_state)

var connected_to_player: Array = []
