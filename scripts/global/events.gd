extends Node

signal bulb_popped(lvl: int, progress: float)

signal shop_closed

signal player_interacted(snowman_data: SnowmanData)

signal player_connected(player: Player)
signal player_sprinted
signal player_jumped(jump_cost: float)

signal player_move_state_changed(new_state)
signal player_ground_state_changed(new_state)
