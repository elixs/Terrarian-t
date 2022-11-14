extends KinematicBody2D

signal target_reached()



var SPEED = 150
var ACCELERATION = 500

var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var has_target = false
var target = Vector2.ZERO

var player

onready var area_2d = $Area2D


func _ready():
	area_2d.connect("body_entered", self, "_on_body_entered")
	area_2d.connect("body_exited", self, "_on_body_exited")

func take_damage():
	print("oh no!")

func _physics_process(delta):
	
	if player:
		move_to(player.global_position)
	
	velocity = move_and_slide(velocity)
	if has_target:
		var distance = (target - global_position).length()
		if distance < SPEED * delta:
			has_target = false
			emit_signal("target_reached")
			direction = Vector2.ZERO
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
