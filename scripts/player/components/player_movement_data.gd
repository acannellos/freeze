class_name PlayerMovementData
extends Resource

@export var base_speed: float = 10.0
@export_range(0.0, 1.0) var base_acceleration: float = 0.25
@export_range(0.0, 1.0) var air_multiplier: float = 0.5
@export var sprint_multiplier: float = 2.0
@export var jump_velocity: float = 8.0
@export var max_air_jumps: int = 10

@export var sprint_cost: int = 1
@export var jump_cost: int = 1

func get_base_speed() -> float:
	return base_speed
	
func get_sprint_speed() -> float:
	return base_speed * sprint_multiplier

func get_jump_velocity() -> float:
	return jump_velocity

func get_base_acceleration() -> float:
	return base_acceleration

func get_air_acceleration() -> float:
	return base_acceleration * air_multiplier 
