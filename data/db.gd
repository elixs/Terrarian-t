extends Node

var inventory_data = {}


func _ready():
	print("load_db")
	load_db()


func load_db():
	var file = File.new()
	file.open("res://data/db.json", File.READ)
	var content = file.get_as_text()
	file.close()
	inventory_data = JSON.parse(content).result
