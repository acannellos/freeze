class_name Enemy
extends PathFollow3D

@onready var mesh: MeshInstance3D = $mesh
@onready var body_col: CollisionShape3D = $body/col
@onready var area_col: CollisionShape3D = $area/col

var level: int = 1

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	mesh.show()
	body_col.disabled = false
	area_col.disabled = false

func _process(delta: float) -> void:
	progress += 0.1

func die() -> void:
	Global.snowflakes += 1
	if level > 1:
		level -= 1
	else:
		queue_free()
