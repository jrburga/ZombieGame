tool
extends Node2D
class_name WeaponNode


export(Resource) var weapon_res
export(PackedScene) var BulletScene
export(float) var bullet_speed = 100

var bullet_root : Node2D = null
var weapon_child = null

func _ready():
	set_weapon(weapon_res)
	
func _unhandled_input(event):
	if event is InputEvent:
		if event.is_pressed() and event.is_action("cheat_swap_weapon"):
			var wdb = WeaponsDB.get_weapons_db(self) as WeaponsDB
			var num_weapons = wdb.get_num_weapons()
			var index = wdb.find(weapon_res)
			index = (index + 1) % num_weapons
			var new_weapon = wdb.get_weapon_at(index)
			print(index, " - ", new_weapon.display_name)
			set_weapon(new_weapon)
	
func trigger_primary():
	if bullet_root:
		var bullet = BulletScene.instance() as Bullet
		get_node('/root').add_child(bullet)
		bullet.global_position = bullet_root.global_position
		var delta = get_global_mouse_position() - bullet_root.global_position
		var direction = delta.normalized()
		bullet.velocity = direction * bullet_speed
	
func set_weapon(in_weapon_res : WeaponResource):
	if weapon_child:
		remove_child(weapon_child)
	weapon_child = null
	bullet_root = null
	weapon_res = in_weapon_res
	if weapon_res:
		if weapon_res is WeaponResource:
			weapon_child = weapon_res.WeaponScene.instance()
			add_child(weapon_child)
			
	if weapon_child:
		bullet_root = weapon_child.find_node("BulletRoot")
			
func remove_weapon():
	if weapon_child:
		remove_child(weapon_child)
	weapon_child = null
	bullet_root = null

