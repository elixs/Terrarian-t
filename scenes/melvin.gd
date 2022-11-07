extends KinematicBody2D


var velocity = Vector2()

var SPEED = 100
var ACCELERATION = 1000
var GRAVITY = 400

var COYOTE_TIME = 0.2
var airborn_time = 999


onready var sprite: Sprite = $Sprite


#func _ready() -> void:
#	Engine.time_scale = 0.1

func _physics_process(delta: float) -> void:
	velocity = move_and_slide(velocity, Vector2.UP)
	
	var move_input = Input.get_axis("move_left", "move_right")
	
	velocity.x = move_toward(velocity.x, move_input * SPEED, ACCELERATION)
	
	velocity.y += GRAVITY * delta
	
	
	if is_on_floor():
		airborn_time = 0
	else:
		airborn_time += delta
	
	if is_on_floor() or airborn_time <= COYOTE_TIME:
		sprite.modulate = Color.green
	else:
		sprite.modulate = Color.red
		
	if (is_on_floor() or airborn_time <= COYOTE_TIME) and  Input.is_action_just_pressed("jump"):
		velocity.y = - 1.5 * SPEED
		airborn_time = COYOTE_TIME

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()
