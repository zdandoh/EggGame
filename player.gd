extends KinematicBody2D

export (int) var speed = 200

var gravity = 750
var jump_speed = -450
var velocity = Vector2()

var egg = preload("res://egg.tscn")
var ghost = preload("res://ghost.tscn")

# Called when the node enters the scene tree for the first time.

func _ready():
	$Camera2D.current = true

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
	if do_walk && !$AnimatedSprite.playing:
		$AnimatedSprite.play("walk")
	elif !do_walk && $AnimatedSprite.animation != "egging" && is_on_floor():
		$AnimatedSprite.stop()
		$AnimatedSprite.frame = 0
	
	if Input.is_action_just_pressed("egg_toggle"):
		$AnimatedSprite.play("egging")
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed

func _physics_process(delta):
	if $AnimatedSprite.animation == "death":
		return
	var before_y = velocity.y
	
	velocity.y += gravity * delta
	get_input()
	
	velocity = move_and_slide(velocity, Vector2(0, -1))
	for i in get_slide_count():
		var coll = get_slide_collision(i)
		if coll.collider.name.begins_with("JumpShroom"):
			velocity.y = jump_speed * 1.5
		if coll.collider.name.begins_with("Enemy"):
			die()

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "egging":
		$AnimatedSprite.stop()
		var new_egg = egg.instance()
		new_egg.position = position
		new_egg.linear_velocity.x = velocity.x / 4
		new_egg.linear_velocity.y = velocity.y
		get_parent().add_child(new_egg)
		$Camera2D.current = false
		$CollisionShape2D.disabled = true
		$AnimatedSprite.play("death")
	if $AnimatedSprite.animation == "death":
		var new_ghost = ghost.instance()
		new_ghost.position = position
		get_parent().add_child(new_ghost)
		queue_free()

func die():
	$AnimatedSprite.play("death")
	var new_cam = Camera2D.new()
	new_cam.position = position
	new_cam.current = true
	get_parent().add_child(new_cam)
	$Camera2D.current = false
