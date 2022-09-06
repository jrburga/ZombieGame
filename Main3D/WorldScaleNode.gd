tool
extends Spatial

export(Vector3) var world_scale = Vector3(1, 1, 1) setget _on_set_world_scale
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _on_set_world_scale(value):
	world_scale = value
	scale = world_scale

# Called when the node enters the scene tree for the first time.
func _ready():
	scale = world_scale


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
