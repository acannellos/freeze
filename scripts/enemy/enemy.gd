class_name Enemy
extends PathFollow3D

@onready var bulb: Node3D = $bulb
@onready var body_col: CollisionShape3D = $body/col
@onready var area_col: CollisionShape3D = $area/col

@onready var sphere: MeshInstance3D = $bulb/Sphere

@export var red: StandardMaterial3D
@export var blue: StandardMaterial3D
@export var green: StandardMaterial3D
@export var orange: StandardMaterial3D
@export var white: StandardMaterial3D

var level: int = 1
var progress_speed: float = 0.2

func _ready() -> void:
	bulb.hide()
	await get_tree().create_timer(0.1).timeout
	bulb.show()
	body_col.disabled = false
	area_col.disabled = false
	match_level()

func match_level() -> void:
	match level:
		1:
			sphere.set_surface_override_material(0, red)
			progress_speed = 0.2
		2:
			sphere.set_surface_override_material(0, blue)
			progress_speed = 0.24
		3:
			sphere.set_surface_override_material(0, green)
			progress_speed = 0.32
		4:
			sphere.set_surface_override_material(0, orange)
			progress_speed = 0.48
		5:
			sphere.set_surface_override_material(0, white)
			progress_speed = 0.6


func _process(delta: float) -> void:
	progress += progress_speed
	if progress_ratio > 0.99:
		Global.presents -= level
		queue_free()

func die() -> void:
	Global.snowflakes += 1
	if level > 1:
		#level -= 1
		Events.bulb_popped.emit(level, progress_ratio)
		queue_free()
	else:
		queue_free()
