extends MarginContainer

onready var play = $VBoxContainer/Play
onready var credits = $VBoxContainer/Credits
onready var exit = $VBoxContainer/Exit

export(PackedScene) var first_level

func _ready():
	play.connect("pressed", self, "_on_play_pressed")
	credits.connect("pressed", self, "_on_credits_pressed")
	exit.connect("pressed", self, "_on_exit_pressed")
	
	play.grab_focus()
	
#	var meh = get_focus_owner()
#	meh.release_focus()


func _on_play_pressed():
	Fade.change_scene(first_level)


func _on_credits_pressed():
	get_tree().change_scene("res://scenes/ui/credits.tscn")

func _on_exit_pressed():
	get_tree().quit()
