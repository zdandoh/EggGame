extends KinematicBody2D

export (int) var speed = 50

var gravity = 750
var jump_speed = -450
var velocity = Vector2()
var dir = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("walk")

func _physics_process(delta):
	if !$RayCast2D.is_colliding():
		dir *= -1
		$AnimatedSprite.set_flip_h(dir != 1)
	velocity.y += gravity * delta
	velocity.x = speed * dir
	velocity = move_and_slide(velocity, Vector2(0, -1))
