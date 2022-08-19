extends Sprite

var max_distance = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_as_toplevel(true)
	$Secondary.set_as_toplevel(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = get_global_mouse_position() - owner.global_position
	var distance = min(max_distance, direction.length())
	direction = direction.normalized() * distance
	global_position = owner.global_position + direction
	
	$Secondary.global_position = get_global_mouse_position()
