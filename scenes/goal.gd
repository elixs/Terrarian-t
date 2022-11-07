extends Area2D


export(PackedScene) var next_level

func _ready():
	connect("body_entered", self, "_on_body_entered")


func _on_body_entered(body: Node):
	Fade.change_scene(next_level)
