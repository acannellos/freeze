#@tool
extends Node3D

@onready var label_3d: Label3D = $Label3D

func _process(delta: float) -> void:
	rotation.y += delta
	label_3d.text = str(Global.presents) + "/40"
