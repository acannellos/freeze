extends Node3D

func _process(delta: float) -> void:
	rotation += Vector3.ONE * delta
