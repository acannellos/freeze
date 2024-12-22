extends VBoxContainer

@onready var snowflake_label: Label = $snowflakes/snowflake_label
@onready var present_label: Label = $presents/present_label

func _process(delta: float) -> void:
	snowflake_label.text = str(Global.snowflakes)
	present_label.text = str(Global.presents)

	#update_label("snowflakes", Global.snowflakes)
	#update_label("presents", Global.presents)
