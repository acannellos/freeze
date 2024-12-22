extends Node

var snowflakes: int = 6500
var presents: int = 40

var base_snowman_price: float = 250.0

var selected_snowman: Snowman

var gravity: float = 20

var player: Player

var enemy_count: int = 0

enum GameState {PLAYING, PAUSED}
var game_state: GameState = GameState.PLAYING
