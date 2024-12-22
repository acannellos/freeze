extends Control

@export var sell_multi: float = 0.8
@export var head_price: float = 100.0
@export var arms_price: float = 100.0
@export var eyes_price: float = 100.0
@export var hat_price: float = 100.0
@export var nose_price: float = 100.0
@export var scarf_price: float = 100.0

@onready var hbox: HBoxContainer = $NinePatchRect/hbox

var temp_snowman_data: SnowmanData = SnowmanData.new()

func _unhandled_input(event: InputEvent):
	if Input.is_action_just_pressed("upgrade_1") and visible:
		if not temp_snowman_data.has_head and Global.snowflakes >= head_price:
			Global.snowflakes -= head_price
			temp_snowman_data.has_head = true
			update_hbox()
			Global.selected_snowman.show_head()
			Global.selected_snowman.update_price(head_price)
			update_price_label()
		
	if Input.is_action_just_pressed("upgrade_2") and visible and temp_snowman_data.has_head:
		# TODO check snowflakes
		if not temp_snowman_data.has_arms and Global.snowflakes >= arms_price:
			Global.snowflakes -= arms_price
			temp_snowman_data.has_arms = true
			update_hbox()
			Global.selected_snowman.show_arms()
			Global.selected_snowman.update_price(arms_price)
			update_price_label()
		
	if Input.is_action_just_pressed("upgrade_3") and visible and temp_snowman_data.has_head:
		# TODO check snowflakes
		if not temp_snowman_data.has_eyes and Global.snowflakes >= eyes_price:
			Global.snowflakes -= eyes_price
			temp_snowman_data.has_eyes = true
			update_hbox()
			Global.selected_snowman.show_eyes()
			Global.selected_snowman.update_price(eyes_price)
			update_price_label()
		
	if Input.is_action_just_pressed("upgrade_4") and visible and temp_snowman_data.has_head:
		# TODO check snowflakes
		if not temp_snowman_data.has_hat and Global.snowflakes >= hat_price:
			Global.snowflakes -= hat_price
			temp_snowman_data.has_hat = true
			update_hbox()
			Global.selected_snowman.show_hat()
			Global.selected_snowman.update_price(hat_price)
			update_price_label()
		
	if Input.is_action_just_pressed("upgrade_5") and visible and temp_snowman_data.has_head:
		# TODO check snowflakes
		if not temp_snowman_data.has_nose and not temp_snowman_data.has_scarf and Global.snowflakes >= nose_price:
			Global.snowflakes -= nose_price
			temp_snowman_data.has_nose = true
			update_hbox()
			Global.selected_snowman.show_nose()
			Global.selected_snowman.update_price(nose_price)
			update_price_label()
		
	if Input.is_action_just_pressed("upgrade_6") and visible and temp_snowman_data.has_head:
		# TODO check snowflakes
		if not temp_snowman_data.has_nose and not temp_snowman_data.has_scarf and Global.snowflakes >= scarf_price:
			Global.snowflakes -= scarf_price
			temp_snowman_data.has_scarf = true
			update_hbox()
			Global.selected_snowman.show_scarf()
			Global.selected_snowman.update_price(scarf_price)
			update_price_label()

	if Input.is_action_just_pressed("sell") and visible:
		var sell_price = Global.selected_snowman.current_price * sell_multi
		Global.selected_snowman.cleanup()
		Global.snowflakes += sell_price
	
	if Input.is_action_just_pressed("toggle") and visible:
		Global.selected_snowman.adjust_aim()
		update_toggle_label()


func _ready() -> void:
	Events.connect("player_interacted", _on_player_interacted)
	Events.connect("shop_closed", _on_shop_closed)


func _on_player_interacted(snowman_data: SnowmanData) -> void:
	visible = true
	temp_snowman_data = snowman_data
	update_hbox()
	update_price_label()
	update_toggle_label()

@onready var price_label: Label = $NinePatchRect/sellbox/price/price_label
@onready var current_toggle: Label = $NinePatchRect/togglebox/current_toggle

func update_price_label() -> void:
	var sell_price = Global.selected_snowman.current_price * sell_multi
	price_label.text = str(sell_price)

func update_toggle_label() -> void:
	if Global.selected_snowman.attack.is_aiming_at_back:
		current_toggle.text = "back"
	else:
		current_toggle.text = "front"

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
