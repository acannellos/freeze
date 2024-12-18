class_name Player
extends CharacterBody3D

@export var movement: PlayerMovementData = PlayerMovementData.new()
@export var stats: PlayerStatData = PlayerStatData.new()

@onready var head: PlayerHead = $head
@onready var move_component: PlayerMoveComponent = %movement
@onready var stat_component: PlayerStatComponent = %stats
@onready var snowman_component: PlayerSnowmanComponent = %snowman

var spawn_pos: Vector3 = Vector3.ZERO

func _ready() -> void:
	Events.player_connected.emit(self)
	spawn_pos = global_position

func _input(event: InputEvent) -> void:
	head.handle_camera_input(event)

func _physics_process(delta: float) -> void:
	if can_sprint():
		move_component.handle_sprint_input()
	if can_jump():
		move_component.handle_jump_input()
	move_component.handle_movement(delta)
	snowman_component.handle_snowman_input()
	handle_fall(80)

func can_jump() -> bool:
	return (is_on_floor() or move_component.jump_phase > 0) and \
		stat_component.has_stamina_for(movement.jump_cost)

func can_snowman() -> bool:
	return is_on_floor()

func can_sprint() -> bool:
	return stat_component.has_stamina_for(movement.sprint_cost)

func handle_fall(y_val: float) -> void:
	if global_position.y < -y_val:
		global_position = spawn_pos
