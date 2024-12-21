extends Control

@onready var hbox: HBoxContainer = $NinePatchRect/hbox

var temp_snowman_data: SnowmanData = SnowmanData.new()

func _unhandled_input(event: InputEvent):
	if Input.is_action_just_pressed("upgrade_1") and visible:
		# TODO check snowflakes
		if not temp_snowman_data.has_head:
			print("head")
			temp_snowman_data.has_head = true
			update_hbox()
		
	if Input.is_action_just_pressed("upgrade_2") and visible and temp_snowman_data.has_head:
		# TODO check snowflakes
		if not temp_snowman_data.has_arms:
			temp_snowman_data.has_arms = true
			update_hbox()
		
	if Input.is_action_just_pressed("upgrade_3") and visible and temp_snowman_data.has_head:
		# TODO check snowflakes
		if not temp_snowman_data.has_eyes:
			temp_snowman_data.has_eyes = true
			update_hbox()
		
	if Input.is_action_just_pressed("upgrade_4") and visible and temp_snowman_data.has_head:
		# TODO check snowflakes
		if not temp_snowman_data.has_hat:
			temp_snowman_data.has_hat = true
			update_hbox()
		
	if Input.is_action_just_pressed("upgrade_5") and visible and temp_snowman_data.has_head:
		# TODO check snowflakes
		if not temp_snowman_data.has_nose and not temp_snowman_data.has_scarf:
			temp_snowman_data.has_nose = true
			update_hbox()
		
	if Input.is_action_just_pressed("upgrade_6") and visible and temp_snowman_data.has_head:
		# TODO check snowflakes
		if not temp_snowman_data.has_nose and not temp_snowman_data.has_scarf:
			temp_snowman_data.has_scarf = true
			update_hbox()


func _ready() -> void:
	Events.connect("player_interacted", _on_player_interacted)
	Events.connect("shop_closed", _on_shop_closed)


func _on_player_interacted(snowman_data: SnowmanData) -> void:
	visible = true
	temp_snowman_data = snowman_data
	update_hbox()

func update_hbox() -> void:
	for child in hbox.get_children() as Array[UpgradeVbox]:
		match child.name:
			"head":
				if temp_snowman_data.has_head:
					child.is_purchased = true
				else:
					child.is_purchased = false
				child.apply_all()
			"arms":
				if temp_snowman_data.has_arms:
					child.is_purchased = true
				else:
					child.is_purchased = false
				check_active(child)
			"eyes":
				if temp_snowman_data.has_eyes:
					child.is_purchased = true
				else:
					child.is_purchased = false
				check_active(child)
			"hat":
				if temp_snowman_data.has_hat:
					child.is_purchased = true
				else:
					child.is_purchased = false
				check_active(child)
			"nose":
				child.is_locked = false
				if not temp_snowman_data.has_scarf:
					if temp_snowman_data.has_nose:
						child.is_purchased = true
					else:
						child.is_purchased = false
				else:
					child.is_locked = true
				check_active(child)
			"scarf":
				child.is_locked = false
				if not temp_snowman_data.has_nose:
					if temp_snowman_data.has_scarf:
						child.is_purchased = true
					else:
						child.is_purchased = false
				else:
					child.is_locked = true
				check_active(child)

func check_active(box: UpgradeVbox) -> void:
	if temp_snowman_data.has_head:
		box.is_active = true
	else:
		box.is_active = false
	box.apply_all()

func _on_shop_closed() -> void:
	visible = false
