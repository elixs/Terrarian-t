extends Area2D

export(String) var title
export(Resource) var dialogue


func _ready():
	connect("body_entered", self, "_on_body_entered")


func _on_body_entered(body: Node):
	DialogueManager.show_example_dialogue_balloon(title, dialogue)
	disconnect("body_entered", self, "_on_body_entered")
