tool
extends Node2D
class_name WeaponNode


export(Resource) var weapon_details
export(PackedScene) var BulletScene

var weapon_child = null

func _ready():
	if Engine.editor_hint:
		return
		
	var inventory = owner.find_node("InventoryNode") as InventoryNode
	if inventory:
		var wdb = WeaponsDB.get_weapons_db(self) as WeaponsDB
		for index in wdb.get_num_weapons():
			var wd = WeaponDetails.new()
			
			wd.weapon_resource = wdb.get_weapon_at(index)
			wd.current_ammo = wd.weapon_resource.magazine_size
			inventory.add_weapon(wd)
			
		var weapon = inventory.get_weapon(0)
		if weapon:
			set_weapon(weapon)
	
func _unhandled_input(event):
	if owner.is_dead():
		return
	if event is InputEvent:
		if event.is_pressed() and event.is_action("cheat_swap_weapon"):
			var inventory = owner.find_node("InventoryNode") as InventoryNode
			if inventory:
				var current_index = inventory.weapons.find(weapon_details)
				var num_weapons = inventory.weapons.size()
				
				var new_index = (current_index + 1) % num_weapons
				set_weapon(inventory.get_weapon(new_index))
				
	if weapon_child and event is InputEvent:
		if event.is_action_pressed("attack_primary"):
			weapon_child.trigger_primary_pressed()
		if event.is_action_released("attack_primary"):
			weapon_child.trigger_primary_released()
		if event.is_action_pressed("weapon_reload"):
			weapon_child.reload_pressed()

func get_weapon():
	return weapon_child
	
func set_weapon(in_weapon_details : WeaponDetails):
	if weapon_child:
		remove_child(weapon_child)
		weapon_child.queue_free()
	weapon_child = null
	weapon_details = in_weapon_details
	if weapon_details == null:
		return
		
	var weapon_res = weapon_details.weapon_resource
	if weapon_res:
		weapon_child = weapon_res.WeaponScene.instance()
		
	if weapon_child:
		weapon_child.weapon_details = weapon_details
		weapon_child.crosshair = owner.find_node('Crosshair')
		add_child(weapon_child)
			
func remove_weapon():
	if weapon_child:
		remove_child(weapon_child)
	weapon_child = null

