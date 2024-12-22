class_name SnowmanAttackState
extends SnowmanState

@export var Projectile: PackedScene
@export var area: Area3D
@export var marker: Marker3D

@onready var timer: Timer = $Timer

var enemies: Array = []

enum States {IDLE, ATTACKING}

var current_speed: float = 100.0


func shoot() -> void:
	if timer.is_stopped() and enemies.size() > 0:
		var target = enemies[0]
		#var target = enemies[-1]
		snowman.look_at(target.global_transform.origin)
		timer.start()

		var attack = Projectile.instantiate() as RayCast3D
		attack.set_speed(current_speed)
		add_child(attack)
		attack.global_transform = marker.global_transform

func _ready():
	area.connect("area_entered", _on_area_entered)
	area.connect("area_exited", _on_area_exited)
	call_deferred("set_state", States.IDLE)

func _on_area_entered(area: Area3D) -> void:
	enemies.append(area)

func _on_area_exited(area: Area3D) -> void:
	enemies.erase(area)

func _get_transition():
	if enemies.size() > 0:
		return States.ATTACKING
	return States.IDLE

func _enter_state(new_state):
	match new_state:
		States.IDLE:
			pass

		States.ATTACKING:
			pass

func _state_logic(delta: float) -> void:
	match state:
		States.IDLE:
			pass
		States.ATTACKING:
			shoot()
