class_name Snowman
extends StaticBody3D

@export var snowman_data: SnowmanData = SnowmanData.new()

@onready var area_col: CollisionShape3D = $area/col
@onready var timer: Timer = $attack/Timer

@onready var decal: Decal = $Decal
@onready var range: MeshInstance3D = $range

func hide_range() -> void:
	decal.hide()
	range.hide()
	
func show_range() -> void:
	decal.show()
	range.show()

func upgrade_range() -> void:
	area_col.shape.radius = 30

var range_radius: float = 15.0
var projectile_speed
var attack_speed

var has_head: bool = false
var has_buttons: bool = false
var has_nose: bool = false
var has_scarf: bool = false
var is_full_snowman: bool = false
