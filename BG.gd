extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var egg = get_node_or_null("../Egg")
	var player = get_node_or_null("../Player")
	if egg != null:
		position = egg.position
	if player != null:
		position = player.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
