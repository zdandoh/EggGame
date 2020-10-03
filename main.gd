extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if get_node_or_null("Player") != null:
		$BG.position = $Player.position
	if get_node_or_null("Egg") != null:
		$BG.position = $Egg.position
	if Input.is_action_pressed("reload"):
		get_tree().reload_current_scene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
