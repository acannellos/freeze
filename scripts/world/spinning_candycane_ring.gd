extends MeshInstance3D

@export var sign: float = 1.0

func _process(delta: float) -> void:
	rotation.x += delta * sign
