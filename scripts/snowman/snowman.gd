class_name Snowman
extends StaticBody3D

@export var snowman_data: SnowmanData = SnowmanData.new()
@export var base_price: float = 20.0
var current_price: float = 0

@onready var area_col: CollisionShape3D = $area/col
@onready var timer: Timer = $attack/Timer
@onready var decal: Decal = $Decal
@onready var range: MeshInstance3D = $range
@onready var head: MeshInstance3D = $head
@onready var hat: Node3D = $hat
@onready var nose: MeshInstance3D = $nose
@onready var eyes: Node3D = $eyes
@onready var arms: Node3D = $arms
@onready var scarf: Node3D = $scarf
@onready var attack: SnowmanAttackState = %attack

func _ready() -> void:
	current_price = base_price

func update_price(amt: float) -> void:
	current_price += amt

func hide_range() -> void:
	decal.hide()
	range.hide()
	
func show_range() -> void:
	decal.show()
	range.show()

func show_head() -> void:
	head.show()
	
func show_arms() -> void:
	arms.show()
	attack.current_speed = 400.0

func show_eyes() -> void:
	eyes.show()
	timer.wait_time = 0.6

func show_hat() -> void:
	hat.show()
	range.mesh.radius = 24
	range.mesh.height = 48
	decal.size.x = 54
	decal.size.z = 54
	area_col.shape.radius = 24

func show_nose() -> void:
	nose.show()
	# TODO ability
	
func show_scarf() -> void:
	scarf.show()
	# TODO ability

func cleanup() -> void:
	queue_free()
