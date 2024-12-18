class_name EnemyAttackState
extends EnemyState
#
#@export var color_idle: StandardMaterial3D
#@export var color_attack: StandardMaterial3D
#@export var mesh: MeshInstance3D
#@export var area: Area3D
#@export var orb_scene: PackedScene
#@export var marker: Marker3D
#
#enum States {IDLE, ATTACKING}
#
#@export var Projectile: PackedScene
#
#@onready var timer: Timer = $Timer
#
#func _ready():
	#call_deferred("set_state", States.IDLE)
	#area.connect("body_entered", _on_area_entered)
	#area.connect("body_exited", _on_area_exited)
#
#func _on_area_entered(body) -> void:
	#set_state(States.ATTACKING)
#
#func _on_area_exited(body) -> void:
	#set_state(States.IDLE)
#
##var enemy = enemy_scene.instantiate()
##get_tree().root.add_child(enemy)
#
#func _enter_state(new_state):
	#
	#match new_state:
		#States.IDLE:
			#mesh.set_surface_override_material(0, color_idle)
		#States.ATTACKING:
			#mesh.set_surface_override_material(0, color_attack)
			#shoot()
			##var orb = orb_scene.instantiate()
			##get_tree().root.add_child(orb)
			##orb.global_position = marker.global_position
#
#func shoot() -> void:
	#if timer.is_stopped():
		##if Input.is_action_just_pressed("primary"):
		#timer.start()
		#var attack = Projectile.instantiate() as RayCast3D
		#add_child(attack)
		#attack.global_transform = marker.global_transform
	#
