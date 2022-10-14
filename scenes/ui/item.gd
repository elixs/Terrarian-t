extends HBoxContainer

onready var icon_texture = $Icon
onready var quantity_label = $Quantity
onready var name_label = $Name



var display_name = "" setget set_display_name
var quantity = 0 setget set_quantity
var icon = Vector2.ZERO setget set_icon


#func _ready():
#	icon_texture.texture = icon_texture.texture.duplicate()


func set_display_name(value):
	display_name = value
	name_label.text = value


func set_icon(value):
	icon = value
	var atlas = icon_texture.texture as AtlasTexture
	atlas.region = Rect2(icon.x,icon.y, 24, 24)
	print("asdfadsf")

func set_quantity(value):
	quantity = value
	quantity_label.text = str(value)
