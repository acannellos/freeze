extends Node

var snowflakes: int = 6500
var presents: int = 40
var current_wave = 0

var base_snowman_price: float = 250.0

var selected_snowman: Snowman

var gravity: float = 20

var player: Player
var enemy_count: int = 0

var is_wave_active: bool = false

enum WaveState {WAVE_INACTIVE, WAVE_ACTIVE, WAVE_COMPLETE}
var wave_state: WaveState = WaveState.WAVE_INACTIVE
