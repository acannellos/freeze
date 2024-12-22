extends Path3D

@export var enemy_scene: PackedScene

@export var test_wave: WaveData

@export var all_waves: Array[WaveData]

#if current wave is length of all waves, game over?

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("spawn"):
		spawn_wave(test_wave)

func _process(delta: float) -> void:
	match Global.wave_state:
		Global.WaveState.WAVE_INACTIVE:
			pass
		Global.WaveState.WAVE_ACTIVE:
			pass
		Global.WaveState.WAVE_COMPLETE:
			pass

	if Global.wave_state:
		spawn_wave(Global.current_wave)

func _ready() -> void:
	Events.connect("bulb_popped", _on_bulb_popped)

func _on_bulb_popped(lvl: int, progress: float) -> void:
	var count: int = 1
	for l in lvl:
		var enemy: Enemy = enemy_scene.instantiate()
		enemy.level = lvl - 1
		add_child(enemy)
		var p = max(0, progress - 0.005 * count)
		enemy.progress_ratio = p
		count += 1

func spawn_wave(wave_data: WaveData) -> void:
	for enemy in wave_data.enemies as Array[int]:
		if enemy == 0:
			await get_tree().create_timer(0.8).timeout
		else:
			spawn_enemy(enemy)
		await get_tree().create_timer(0.8).timeout

func spawn_enemy(lvl: int) -> void:
	var enemy: Enemy = enemy_scene.instantiate()
	enemy.level = lvl
	add_child(enemy)
