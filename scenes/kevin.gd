extends KinematicBody2D

#var Bullet = preload("res://scenes/bullet.tscn")
export(PackedScene) var Bullet

var velocity = Vector2()

var ACCELERATION = 1000
var SPEED = 200
var JUMP_SPEED = 200
var GRAVITY = 10

onready var pivot = $Pivot
onready var anim_player = $AnimationPlayer
onready var anim_tree = $AnimationTree
onready var playback = anim_tree.get("parameters/playback")
onready var fire_sfx = $FireSFX
onready var bullet_spawn = $Pivot/BulletSpawn

func _ready():
	anim_tree.active = true


func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	
	var move_input = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	).normalized()
	
	# velocity.x = lerp(move_input * SPEED, velocity.x, 0.99) 
	velocity = velocity.move_toward(move_input * SPEED, ACCELERATION * delta)
	
#	velocity.y += GRAVITY
	
	
#	if is_on_floor() and Input.is_action_just_pressed("jump"):
#		velocity.y = -JUMP_SPEED
	
	
	if Input.is_action_just_pressed("fire"):
		_fire()
	
	# Animations
	
	if Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		pivot.scale.x = 1
	if Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		pivot.scale.x = -1
	
#	if is_on_floor():
	if abs(velocity.length_squared()) > 10:
		playback.travel("run")
	else:
		playback.travel("idle")
#	else:
#		if velocity.y < 0:
#			playback.travel("jump")
#		else:
#			playback.travel("fall")

func _fire():
	fire_sfx.play()
	var bullet = Bullet.instance()
	get_parent().add_child(bullet)
	bullet.global_position = bullet_spawn.global_position
	if pivot.scale.x == -1:
		bullet.rotation = PI
	
