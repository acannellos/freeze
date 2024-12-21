extends Control

func _ready() -> void:
	Events.connect("player_interacted", _on_player_interacted)
	Events.connect("shop_closed", _on_shop_closed)


func _on_player_interacted() -> void:
	visible = true

func _on_shop_closed() -> void:
	visible = false
