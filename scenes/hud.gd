extends MarginContainer


var lives setget set_lives


onready var lives_label = $Lives


func _ready():
	self.lives = Game.player_lives
	

func set_lives(value):
	lives = value
	lives_label.text = "Lives: %d" % lives
