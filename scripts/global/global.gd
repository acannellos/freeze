extends Node

var snowflakes: int = 100
var presents: int = 100

var gravity: float = 20

var player: Player

var enemy_count: int = 0

enum GameState {PLAYING, PAUSED}
var game_state: GameState = GameState.PLAYING
