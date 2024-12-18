extends Marker3D

@export var Projectile: PackedScene

@onready var timer: Timer = $Timer

func _physics_process(delta: float) -> void:
	if timer.is_stopped():
		if Input.is_action_just_pressed("primary"):
			timer.start()
			var attack = Projectile.instantiate() as RayCast3D
			add_child(attack)
			attack.global_transform = global_transform
