extends Node

var _weapon_resources : Array = []

static func get_weapons_db(context):
	if context:
		return context.get_node("/root/WeaponsDB")
	return null

func _ready():
	var path = "res://Weapons/Resources"
	Util.load_resources_in_directory(path, _weapon_resources)
	
func find_weapon(id : String) -> WeaponResource:
	return Util.find_by_id(id, _weapon_resources)
	
func get_num_weapons() -> int:
	return _weapon_resources.size()
	
func get_weapon_at(index : int) -> WeaponResource:
	if index >= 0 and index < _weapon_resources.size():
		return _weapon_resources[index] 
	return null

func find(weapon_res : WeaponResource) -> int:
	return _weapon_resources.find(weapon_res)
