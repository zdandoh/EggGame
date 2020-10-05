extends KinematicBody2D

export (int) var speed = 200

var gravity = 750
var jump_speed = -450
var velocity = Vector2()
var my_flip = false
var dead = false

var egg = preload("res://egg.tscn")
var ghost = preload("res://ghost.tscn")
var meep = preload("res://Meep.tscn")
var huh = preload("res://Huh.tscn")

# Called when the node enters the scene tree for the first time.

func _ready():
	$Camera2D.current = true
	if get_tree().current_scene.name == "tutorial":
		scale.x = -1

func get_input():
	velocity.x = 0
	var do_walk = false
	if Input.is_action_pressed("right"):
		velocity.x += speed
		$AnimatedSprite.set_flip_h(false)
		my_flip = false
		do_walk = true
	if Input.is_action_pressed("left"):
		velocity.x -= speed
		$AnimatedSprite.set_flip_h(true)
		my_flip = true
		do_walk = true
	if do_walk && !$AnimatedSprite.playing:
		$AnimatedSprite.play("walk")
	elif !do_walk && $AnimatedSprite.animation != "egging" && is_on_floor():
		$AnimatedSprite.stop()
		$AnimatedSprite.frame = 0
	
	if Input.is_action_just_pressed("egg_toggle"):
		$AnimatedSprite.play("egging")
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed

func _physics_process(delta):
	if $AnimatedSprite.animation == "death":
		return
	var before_y = velocity.y
	
	velocity.y += gravity * delta
	get_input()
	
	velocity = move_and_slide_with_snap(velocity, Vector2(0, 3), Vector2(0, -1), true)
	for i in get_slide_count():
		var coll = get_slide_collision(i)
		if coll.collider.name.begins_with("JumpShroom"):
			velocity.y = jump_speed * 1.5
			$Beh.play(0.03)
		if coll.collider.name.begins_with("Enemy"):
			die()

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "egging":

		var guh = huh.instance()
		get_parent().add_child(guh)
		guh.play()
		
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
		new_ghost.set_flip_h(my_flip)
		get_parent().add_child(new_ghost)
		queue_free()

func die():
	if dead:
		return
	dead = true
	var sound = meep.instance()
	get_parent().add_child(sound)
	sound.play()
	$AnimatedSprite.play("death")
	var new_cam = Camera2D.new()
	new_cam.position = position
	new_cam.current = true
	get_parent().add_child(new_cam)
	$Camera2D.current = false
