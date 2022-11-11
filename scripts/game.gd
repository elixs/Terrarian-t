extends Node


var player_lives = 1 setget set_player_lives
var player = null 


func stop_player(value):
	if is_instance_valid(player):
		player.can_move = not value


func set_player_lives(value):
	player_lives = value
	if is_instance_valid(player):
		player.hud.lives = value


func game_over():
	get_tree().change_scene("res://scenes/ui/main_menu.tscn")
