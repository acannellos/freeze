extends Path3D

@export var enemy_scene: PackedScene

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("spawn"):
		spawn_enemy()

func spawn_enemy() -> void:
	var enemy: Enemy = enemy_scene.instantiate()
	add_child(enemy)
