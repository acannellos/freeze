class_name Enemy
extends PathFollow3D

func _process(delta: float) -> void:
	progress += 0.1

func die() -> void:
	print("DEATH")
	queue_free()
