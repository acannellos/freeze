extends Node3D

@export var game_scene: PackedScene

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("start_game"):
		if game_scene:
			get_tree().change_scene_to_packed(game_scene)
