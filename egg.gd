extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var _timer = Timer.new()
var player = load("res://player.tscn")
var recent_jump = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D.current = true;
	set_contact_monitor(true)
	contacts_reported = 1
	add_child(_timer)
	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(0.05)
	if get_tree().current_scene.name == "tutorial":
		scale.x = -1

func _physics_process(delta):
	if linear_velocity.x > 0:
		angular_velocity = max(linear_velocity.x / 20, angular_velocity)
	if linear_velocity.x < 0:
		angular_velocity = min(linear_velocity.x / 20, angular_velocity)
	
	if Input.is_action_just_pressed("egg_toggle"):
		var new_player = player.instance()
		new_player.position = position
		new_player.velocity = linear_velocity
		get_parent().add_child(new_player)
		.hide()
		.queue_free()
	
	var bodies = get_colliding_bodies()
	for bod in bodies:
		if bod.name.begins_with("JumpShroom") && !recent_jump:
			apply_impulse(Vector2(0, 0), Vector2(0, -600))
			recent_jump = true
			_timer.start()

func _on_Timer_timeout():
	recent_jump = false
