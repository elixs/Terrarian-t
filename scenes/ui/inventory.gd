extends MarginContainer

onready var items = $Items

var item_scene = preload("res://scenes/ui/item.tscn")

var inventory = {} setget set_inventory

func _ready():
	load_inventory()


func load_inventory():
	var file = File.new()
	file.open("res://data/inventory.json", File.READ)
	var content = file.get_as_text()
	file.close()
	self.inventory = JSON.parse(content).result

func set_inventory(value):
	inventory = value
	_update()


func _update():
	for child in items.get_children():
		items.remove_child(child)
		child.queue_free()
	for item in inventory:
		var ui_item = item_scene.instance()
		items.add_child(ui_item)
		ui_item.display_name = item.display_name
		
		ui_item.quantity = item.quantity
