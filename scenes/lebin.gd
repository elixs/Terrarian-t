extends KinematicBody2D

signal target_reached()

export(NodePath) var player
onready var _player = get_node(player)


var SPEED = 150
var ACCELERATION = 500

var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var has_target = false
var target = Vector2.ZERO

onready var area_2d = $Area2D
onready var agent = $NavigationAgent2D
onready var timer = $Timer


func _ready():
	area_2d.connect("body_entered", self, "_on_body_entered")
	area_2d.connect("body_exited", self, "_on_body_exited")
	agent.set_target_location(_player.global_position)
	timer.connect("timeout", self, "_on_timeout")

func take_damage():
	print("oh no!")

func _physics_process(delta):
	
	
	
	velocity = move_and_slide(velocity)

#	var distance = (target - global_position).length()
#	if distance < SPEED * delta:
#		has_target = false
#		emit_signal("target_reached")
#		direction = Vector2.ZERO
	
	direction = (agent.get_next_location() - global_position).normalized()
#	direction = global_position.direction_to(agent.get_next_location())
	velocity = velocity.move_toward(direction * SPEED, ACCELERATION * delta)


#func _input(event):
#	if event.is_action_pressed("click"):
#		move_to(get_global_mouse_position())


func move_to(new_target: Vector2):
	target = new_target
	direction = (target - global_position).normalized()
	has_target = true

func _on_body_entered(body: Node):
	player = body


func _on_body_exited(body: Node):
	player = null

func _on_timeout():
	agent.set_target_location(_player.global_position)
