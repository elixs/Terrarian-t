class_name Player
extends KinematicBody2D

#var Bullet = preload("res://scenes/bullet.tscn")
export(PackedScene) var Bullet
export(PackedScene) var Smoke

var velocity = Vector2()


var ACCELERATION = 1000
var SPEED = 200
var JUMP_SPEED = 200
var GRAVITY = 10
var KICK_IMPULSE = 1

onready var pivot = $Pivot
onready var anim_player = $AnimationPlayer
onready var anim_tree = $AnimationTree
onready var playback = anim_tree.get("parameters/playback")
onready var fire_sfx = $FireSFX
onready var bullet_spawn = $Pivot/BulletSpawn


onready var hud = $CanvasLayer/HUD



func _ready():
	anim_tree.active = true


func _physics_process(delta):
	# movement
	
	velocity = move_and_slide(velocity, Vector2.ZERO, false, 4, PI/4, false)
	
	var move_input = Input.get_vector(
		"move_left", "move_right",
		"move_up", "move_down"
	).normalized()
	
	# velocity.x = lerp(move_input * SPEED, velocity.x, 0.99) 
	velocity = velocity.move_toward(move_input * SPEED, ACCELERATION * delta)
	
#	velocity.y += GRAVITY
	
	
#	if is_on_floor() and Input.is_action_just_pressed("jump"):
#		velocity.y = -JUMP_SPEED
	
	
	if Input.is_action_just_pressed("fire"):
		_fire()
	
	if Input.is_action_just_pressed("dash"):
		var direction = (get_global_mouse_position() - global_position).normalized()
		velocity = direction * SPEED * 2
	
	var last_collision = get_last_slide_collision()
	if last_collision:
		var collider = last_collision.collider
		if collider is Ball:
			var ball: Ball = collider
			var normal = last_collision.normal
			ball.apply_central_impulse(-normal * KICK_IMPULSE * velocity.length())
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		
		if collision.collider.collision_layer & 4:
			var enemy: Node2D = collision.collider
			var direction = (global_position - enemy.global_position).normalized()
			velocity = direction * SPEED * 2
			hud.lives -= 1
			
	
	# animations
	
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
	var smoke = Smoke.instance()
	bullet_spawn.add_child(smoke)
	smoke.emitting = true
