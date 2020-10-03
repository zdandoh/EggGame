extends KinematicBody2D

export (int) var speed = 200

var gravity = 750
var jump_speed = -450
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("right"):
		velocity.x += speed
		$Sprite.set_flip_h(false)
	if Input.is_action_pressed("left"):
		velocity.x -= speed
		$Sprite.set_flip_h(true)
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed

func _physics_process(delta):
	velocity.y += gravity * delta
	get_input()
	velocity = move_and_slide(velocity, Vector2(0, -1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
