extends RayCast3D

@export var speed: float = 50.0

@onready var remote_transform = RemoteTransform3D.new()

func set_speed(custom_speed: float) -> void:
	speed = custom_speed

func _physics_process(delta: float) -> void:
	position += global_basis * Vector3.FORWARD * delta * speed
	target_position = Vector3.FORWARD * delta * speed
	force_raycast_update()
	var collider = get_collider()
	if is_colliding():
		
		var col_owner = collider.owner
		if col_owner is Enemy:
			col_owner.die()
			cleanup()
			return
		
		global_position = get_collision_point()
		set_physics_process(false)
		collider.add_child(remote_transform)
		remote_transform.global_transform = global_transform
		remote_transform.global_position = global_position
		remote_transform.remote_path = remote_transform.get_path_to(self)
		remote_transform.tree_exited.connect(cleanup)
			
func cleanup() -> void:
	queue_free()
