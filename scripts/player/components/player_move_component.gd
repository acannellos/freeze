class_name PlayerMoveComponent
extends PlayerComponent

@onready var footsteps: AudioStreamPlayer = $footsteps
@export var head: Node3D

var input_dir: Vector2
var input_sprint: bool = false
var speed: float = 5.0
var acceleration: float = 0.25
var direction: Vector3
var jump_phase: int = 0
var previously_floored: bool = false
var nen_multiplier: float = 1.0
var sway_multiplier: float = 40

var is_sliding: bool = false

func handle_jump_input() -> void:
	
	if Input.is_action_just_pressed("jump"):
		player.velocity.y = player.movement.get_jump_velocity()
		jump_phase -= 1
		Events.player_jumped.emit(player.movement.jump_cost)
		Audio.play("sounds/jump_a.ogg, sounds/jump_b.ogg, sounds/jump_c.ogg")
		head.sway(Vector2(0, -abs(player.velocity.y) * sway_multiplier * 2))
	
	if Input.is_action_just_pressed("secondary"):
		is_sliding = true
	
	if Input.is_action_just_released("secondary"):
		is_sliding = false

func handle_sprint_input() -> void:
	input_sprint = Input.is_action_pressed("sprint")

func handle_grounded(delta: float) -> void:
	footsteps.stream_paused = true
	if not player.is_on_floor():
		player.velocity.y -= Global.gravity * delta
	else:
		jump_phase = player.movement.max_air_jumps
	
		if Global.gravity > 0 and not previously_floored:
			Audio.play("sounds/land.ogg")
	
	previously_floored = player.is_on_floor()

func handle_movement(delta: float) -> void:
	handle_grounded(delta)
	input_dir = Input.get_vector("left", "right", "forward", "backward")
	
	if input_dir:
		direction = player.head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)
		direction.normalized()
		head.sway(Vector2(input_dir.x * sway_multiplier, -abs(input_dir.y) * sway_multiplier))
		if player.is_on_floor():
			footsteps.stream_paused = false

	else:
		direction = Vector3.ZERO
	
	player.velocity.x = lerp(player.velocity.x, direction.x * speed, acceleration)
	player.velocity.z = lerp(player.velocity.z, direction.z * speed, acceleration)
	
	player.move_and_slide()

#func handle_slide() -> void:
	#if is_sliding:
		#var slide_dir: Vector3 = player.head.transform.basis.x * Vector3.FORWARD
		##player.velocity.x = lerp(player.velocity.x, -slide_dir.x * speed * 10, acceleration)
		#player.velocity.z = lerp(player.velocity.z, -slide_dir.z * speed * 10, acceleration)
		#player.move_and_slide()
	#
	#if is_sliding:
		#print("sliding")
		#player.velocity.x = lerp(player.velocity.x, direction.x * speed * 10, acceleration)
		#player.velocity.z = lerp(player.velocity.z, direction.z * speed * 10, acceleration)
		#player.move_and_slide()


func set_speed(new_speed: float) -> void:
	speed = new_speed

func set_acceleration(new_acceleration: float) -> void:
	acceleration = new_acceleration
