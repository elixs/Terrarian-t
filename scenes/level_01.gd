extends Node2D


func _input(event):
	if event.is_action_pressed("next_level"):
		get_tree().change_scene("res://scenes/level_02.tscn")
