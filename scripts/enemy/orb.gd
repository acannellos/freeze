extends Node3D

@onready var shape: ShapeCast3D = $shape
@onready var mesh: MeshInstance3D = $mesh
@onready var buffer: Timer = $buffer

var SPEED := 10
var is_dirty: bool = false

func _process(delta):
	position += transform.basis * Vector3(0, 0, -SPEED) * delta
	if shape.is_colliding():
		if is_dirty:
			return
		is_dirty = true
		#buffer.start()
		SPEED = -SPEED

		#mesh.visible = false
		#await get_tree().create_timer(2.0).timeout
		#queue_free()
	is_dirty = false

func _on_timer_timeout() -> void:
	queue_free()


func _on_buffer_timeout() -> void:
	is_dirty = false
