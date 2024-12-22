extends Path3D

@export var enemy_scene: PackedScene

@export var test_wave: WaveData

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("spawn"):
		#spawn_enemy()
		spawn_wave(test_wave)

func spawn_wave(wave_data: WaveData) -> void:
	for enemy in wave_data.enemies:
		spawn_enemy()
		await get_tree().create_timer(0.8).timeout

func spawn_enemy() -> void:
	var enemy: Enemy = enemy_scene.instantiate()
	add_child(enemy)
