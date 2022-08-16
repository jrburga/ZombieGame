extends Node2D
class_name WeaponBase

export(PackedScene) var BulletScene : PackedScene
export(float) var bullet_speed = 300
onready var bullet_root = find_node("BulletRoot")

var weapon_res : WeaponResource

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

func trigger_primary():
	
	var colleded = false
	
	$Sprite/RayCast2D.cast_to.x = weapon_res.hit_range
	$Sprite/RayCast2D.force_raycast_update()
	
	var hit = $Sprite/RayCast2D.is_colliding()
	var collision_point = Vector2(0, 0)
	if hit:
		collision_point = $Sprite/RayCast2D.get_collision_point()
	
	if bullet_root:
		var bullet = BulletScene.instance() as Bullet
		bullet.global_position = bullet_root.global_position
		var delta = get_global_mouse_position() - bullet_root.global_position
		var direction = delta.normalized()
#		bullet.velocity = direction * bullet_speed
#		bullet.max_distance = weapon_res.hit_range
		
		if hit:
			bullet.target_position = collision_point
			bullet.emit_particles = true
		else:
			bullet.target_position = bullet_root.global_position + direction * weapon_res.hit_range
		bullet.speed = bullet_speed
		
		get_node('/root').add_child(bullet)

