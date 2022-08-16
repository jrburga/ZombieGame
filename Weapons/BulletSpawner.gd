extends Node2D
class_name BulletSpawner

export(PackedScene) var BulletScene : PackedScene
export(float) var bullet_speed = 300

var weapon_res : WeaponResource

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

func spawn_bullet(target_position : Vector2):
	
	var bullet = BulletScene.instance() as Bullet
	bullet.global_position = global_position
	var delta = target_position - global_position
	var direction = delta.normalized()
#		bullet.velocity = direction * bullet_speed
#		bullet.max_distance = weapon_res.hit_range
	
	bullet.velocity = direction * bullet_speed
	
	get_node('/root').add_child(bullet)

