extends RayCast2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process_physics(delta):
	if is_colliding():
		var coll = get_collider()
		print(coll)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
