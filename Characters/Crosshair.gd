extends Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_as_toplevel(true)

#	Input.set_custom_mouse_cursor(null)
#	Input.set_custom_mouse_cursor(cursor_image)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = get_global_mouse_position()
