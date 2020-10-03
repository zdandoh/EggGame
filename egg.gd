extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player = load("res://player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	angular_velocity = max(linear_velocity.x / 20, angular_velocity)
	if Input.is_action_just_pressed("egg_toggle"):
		var new_player = player.instance()
		new_player.position = position
		new_player.velocity = linear_velocity
		get_parent().add_child(new_player)
		.hide()
		.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D_body_entered(body):
	print(body)


func _on_Area2D_body_exited(body):
	print("exit")
