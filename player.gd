extends KinematicBody2D

export (int) var speed = 200

var gravity = 750
var jump_speed = -450
var velocity = Vector2()

var egg = preload("res://egg.tscn")

# Called when the node enters the scene tree for the first time.

func get_input():
	velocity.x = 0
	var do_walk = false
	if Input.is_action_pressed("right"):
		velocity.x += speed
		$AnimatedSprite.set_flip_h(false)
		do_walk = true
	if Input.is_action_pressed("left"):
		velocity.x -= speed
		$AnimatedSprite.set_flip_h(true)
		do_walk = true
	if do_walk:
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.stop()
		$AnimatedSprite.frame = 0
	
	if !is_on_floor():
		$AnimatedSprite.play("jump")
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed

func _physics_process(delta):
	var before_y = velocity.y
	
	velocity.y += gravity * delta
	get_input()
	
	if Input.is_action_just_pressed("egg_toggle"):
		$AnimatedSprite.play("egging")
		var new_egg = egg.instance()
		new_egg.position = position
		get_parent().add_child(new_egg)
		.hide()
		.queue_free()
	
	velocity = move_and_slide(velocity, Vector2(0, -1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimatedSprite_animation_finished():
	pass # Replace with function body.
