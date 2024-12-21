extends VBoxContainer

@export var label_scene: PackedScene
@export var label_large_scene: PackedScene

var labels = {
	"fps": null,
	"snowflakes": null,
	"presents": null,
}

func _ready() -> void:
	create_labels()

func _physics_process(delta: float) -> void:
	update_label("fps", Engine.get_frames_per_second())
	update_label("snowflakes", Global.snowflakes)
	update_label("presents", Global.presents)

func create_labels() -> void:
	for label_name in labels:
		if label_name == "ability":
			create_label_large(label_name)
		else:
			create_label(label_name)

func create_label(label_name: String):
	var new_label = label_scene.instantiate()
	labels[label_name] = new_label
	add_child(new_label)

func create_label_large(label_name: String):
	var new_label = label_large_scene.instantiate()
	labels[label_name] = new_label
	add_child(new_label)

func update_label(label_name: String, value):
	if label_name in labels:
		labels[label_name].text = label_name + ": " + str(value)
