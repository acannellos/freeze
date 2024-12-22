class_name Enemy
extends PathFollow3D

@onready var bulb: Node3D = $bulb
@onready var body_col: CollisionShape3D = $body/col
@onready var area_col: CollisionShape3D = $area/col

var level: int = 1

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	bulb.show()
	body_col.disabled = false
	area_col.disabled = false

func _process(delta: float) -> void:
	progress += 0.2
	if progress_ratio > 0.99:
		Global.presents -= 1
		queue_free()

func die() -> void:
	Global.snowflakes += 1
	if level > 1:
		level -= 1
	else:
		queue_free()
