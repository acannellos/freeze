class_name UpgradeVbox
extends VBoxContainer

@export var upgrade_data: UpgradeData = UpgradeData.new()
@export var is_active: bool = false
@export var is_purchased: bool = false
@export var is_locked: bool = false

@onready var input_label: Label = $input_label
@onready var title: Label = $title
@onready var tex: TextureRect = $upgrade/MarginContainer/tex
@onready var price_label: Label = $price/price_label
@onready var description: Label = $description

@onready var upgrade: TextureRect = $upgrade
@onready var price: HBoxContainer = $price

const PANEL_FILL = preload("res://assets/textures/panel_fill.png")
const PANEL_HASH = preload("res://assets/textures/panel_hash.png")
const PANEL_HASH_GREEN = preload("res://assets/textures/panel_hash_green.png")
const PANEL_HASH_RED = preload("res://assets/textures/panel_hash_red.png")

func _ready() -> void:
	apply_upgrade_data()
	apply_all()

func apply_upgrade_data() -> void:
	input_label.text = upgrade_data.input_key_text
	title.text = upgrade_data.title_text
	tex.texture = upgrade_data.image
	price_label.text = upgrade_data.price_text
	description.text = upgrade_data.description_text

func apply_all() -> void:
	apply_active()
	apply_inactive()
	apply_purchased()
	apply_locked()

func apply_active() -> void:
	if is_active:
		upgrade.texture = PANEL_FILL
		tex.modulate = Color(1,1,1,1)
		price.modulate = Color(1,1,1,1)
		description.modulate = Color(1,1,1,1)

func apply_inactive() -> void:
	if not is_active:
		#input_label.modulate = Color(1,1,1,0)
		upgrade.texture = PANEL_HASH
		tex.modulate = Color(1,1,1,0.2)
		price.modulate = Color(1,1,1,0)
		description.modulate = Color(1,1,1,0)

func apply_purchased() -> void:
	if is_purchased:
		#input_label.modulate = Color(1,1,1,0)
		upgrade.texture = PANEL_HASH_GREEN
		#tex.modulate = Color(1,1,1,0.2)
		price.modulate = Color(1,1,1,0)
		description.modulate = Color(1,1,1,0)

func apply_locked() -> void:
	if is_locked:
		#input_label.modulate = Color(1,1,1,0)
		upgrade.texture = PANEL_HASH_RED
		tex.modulate = Color(1,1,1,0.2)
		price.modulate = Color(1,1,1,0)
		description.modulate = Color(1,1,1,0)
