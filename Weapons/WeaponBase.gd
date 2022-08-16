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
	$Sprite/BulletSpawner.spawn_bullet(get_global_mouse_position())


