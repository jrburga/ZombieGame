tool
extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const PIXEL_SIZE = 1.0 / 16.0
const PIXEL_VECTOR = Vector3(PIXEL_SIZE, PIXEL_SIZE * 5.0 / 4.0, PIXEL_SIZE * 5.0 / 3.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#	owner.global_translation
#	var snap_vector = owner.global_transform.origin - owner.global_transform.origin.snapped(PIXEL_VECTOR)
#	transform.origin = -snap_vector
