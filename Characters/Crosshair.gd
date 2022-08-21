extends Sprite
class_name Crosshair

var max_distance = 100
export(Texture) var mouse_texture = null

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	Input.set_custom_mouse_cursor(mouse_texture)
	set_as_toplevel(true)
	$Secondary.set_as_toplevel(true)
	
func _input(event : InputEvent):
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if owner.is_dead():
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		Input.set_custom_mouse_cursor(null)
		
	var weapon_node = owner.find_node('WeaponNode') as WeaponNode
	var weapon_res = weapon_node.weapon_details.weapon_resource as WeaponResource
	max_distance = weapon_res.weapon_range
	
	var root_position = owner.global_position
	if weapon_node.weapon_child:
		var bullet_spawner = weapon_node.weapon_child.find_node('BulletSpawner')
		root_position = bullet_spawner.global_position if bullet_spawner else root_position
	var direction = get_global_mouse_position() - root_position
	var distance = min(max_distance, direction.length())
	direction = direction.normalized() * distance
	global_position = root_position + direction
	
	$Secondary.global_position = get_global_mouse_position()
