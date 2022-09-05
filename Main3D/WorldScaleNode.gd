extends Spatial

export(Vector3) var world_scale = Vector3(1, 1, 1)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	scale = world_scale


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
