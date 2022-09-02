extends Area2D

var SPEED = 200


func _ready():
	connect("body_entered", self, "_on_body_entered")

func _physics_process(delta):
	position += SPEED * transform.x * delta

func _on_body_entered(body: Node):
#	body.is_in_group("enemy")
	if body.has_method("take_damage"):
		body.take_damage()
	queue_free()
