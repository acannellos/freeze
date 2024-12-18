class_name PlayerHead
extends Node3D

@onready var camera: Camera3D = $camera
@onready var sub_camera: Camera3D = $camera/svc/sv/sub_camera
@onready var marker: Marker3D = $camera/svc/sv/sub_camera/marker

var og_pos: Vector3
var og_rot: Basis
var max_deg: float = 90
var sway_thresh: float = 0.0001

func _ready() -> void:
	og_pos = marker.position
	og_rot = marker.basis
	
func _physics_process(delta: float) -> void:
	sub_camera.global_transform = camera.global_transform
	marker.position = lerp(marker.position, og_pos, delta * 5)

func handle_camera_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * Settings.sensitivity)
		camera.rotate_x(-event.relative.y * Settings.sensitivity)
		camera.rotation.x = clamp(
			camera.rotation.x,
			deg_to_rad(-max_deg),
			deg_to_rad(max_deg)
		)
		sway(Vector2(event.relative.x, event.relative.y))

func lerp_fov_to(desired_fov: float) -> void:
	camera.fov = lerp(camera.fov, desired_fov, 0.1)

func sway(sway_amt: Vector2) -> void:
	marker.position.x -= sway_amt.x * sway_thresh
	marker.position.y += sway_amt.y * sway_thresh

func sway_z(sway_amt: float) -> void:
	marker.position.z += sway_amt * sway_thresh
