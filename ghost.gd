extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var goal = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_tree().current_scene.name == "tutorial":
		scale.x = -1
	modulate.a = 0.8
	play("default")


func _physics_process(delta):
	if position.y <= -600:
		queue_free()
	if goal == 0:
		var r = randi()
		if r % 2 == 0:
			goal = 20
		else:
			goal = -20
	if goal < 0:
		position.x += 1
		goal += 1
	else:
		position.x -= 1
		goal -= 1
	position.y -= 3
