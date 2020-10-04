extends Sprite

export (String) var target = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_Area2D_body_entered(body):
	get_tree().change_scene(target)
