extends KinematicBody2D

export (int) var speed = 50
export (bool) var detect_fall = true

var gravity = 750
var jump_speed = -450
var velocity = Vector2()
var dir = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("walk")

func _physics_process(delta):
	if !$RayCast2D.is_colliding() && detect_fall:
		flip()
	velocity.y += gravity * delta
	velocity.x = speed * dir
	velocity = move_and_slide(velocity, Vector2(0, -1))
	for i in get_slide_count():
		var coll = get_slide_collision(i)
		if coll.collider.name.begins_with("Fence"):
			flip()
		if coll.collider.name.begins_with("Player"):
			coll.collider.die()

func flip():
	dir *= -1
	$AnimatedSprite.set_flip_h(dir != 1)
