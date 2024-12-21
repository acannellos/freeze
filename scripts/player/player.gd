class_name Player
extends CharacterBody3D

@export var movement: PlayerMovementData = PlayerMovementData.new()
@export var stats: PlayerStatData = PlayerStatData.new()

@onready var head: PlayerHead = $head
@onready var move_component: PlayerMoveComponent = %movement
@onready var stat_component: PlayerStatComponent = %stats
@onready var snowman_component: PlayerSnowmanComponent = %snowman

@onready var ray: RayCast3D = $head/camera/svc/sv/sub_camera/ray
@onready var interact_tex: NinePatchRect = $player_UI/interact_tex

var spawn_pos: Vector3 = Vector3.ZERO

var is_upgrade_open: bool = false

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
	handle_interact_input()
	handle_interact_label()

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

func handle_interact_input() -> void:
	if ray.is_colliding() and Input.is_action_just_pressed("interact"):
		var col: Snowman = ray.get_collider()
		var collided_data: SnowmanData = col.snowman_data
		Events.player_interacted.emit(collided_data)
		is_upgrade_open = true
		#print("interact")

func handle_interact_label() -> void:
	if ray.is_colliding():
		interact_tex.show()
		if is_upgrade_open:
			interact_tex.hide()
	else:
		interact_tex.hide()
		is_upgrade_open = false
		Events.shop_closed.emit()
