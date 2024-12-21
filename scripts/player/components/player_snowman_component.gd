class_name PlayerSnowmanComponent
extends PlayerComponent

@export var snowman_scene: PackedScene
@export var marker_snowman: Marker3D
@export var held_snowman: MeshInstance3D
@export var snowman_range: MeshInstance3D
@export var snowman_decal: Decal
@export var snowman_cost: int = 20

var is_range_visible = true

func _ready() -> void:
	held_snowman.hide()

func handle_snowman_input():
	if Input.is_action_just_pressed("secondary"):
		_toggle_show()
	
	if Input.is_action_just_released("secondary") and held_snowman.visible:
		if owner.is_on_floor() and Global.snowflakes >= snowman_cost:
			_create_snowman()
		else:
			_toggle_hide()
	
	if Input.is_action_just_pressed("range") and !held_snowman.visible:
		for range in get_tree().get_nodes_in_group("ranges"):
			range.visible = !range.visible
			is_range_visible = range.visible

func _create_snowman() -> void:
	Global.snowflakes -= snowman_cost
	_toggle_hide()
	var snowman: Snowman = snowman_scene.instantiate() as Snowman
	get_tree().root.add_child(snowman)
	var new_pos = marker_snowman.global_position
	new_pos.y = 0
	snowman.position = new_pos
	if is_range_visible:
		snowman.show_range()
	else:
		snowman.hide_range()

func _toggle_show() -> void:
	held_snowman.show()
	snowman_range.show()
	snowman_decal.show()

func _toggle_hide() -> void:
	held_snowman.hide()
	snowman_range.hide()
	snowman_decal.hide()
