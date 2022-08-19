extends Reference
class_name DamageDetails

func _init(weapon_resource : WeaponResource = null):
	
	if weapon_resource == null:
		return
		
	delta_health = -weapon_resource.damage_per_bullet
	knock_back = weapon_resource.knock_back
	knock_back_power = weapon_resource.knock_back_power
	stun = weapon_resource.stun
	stun_time = weapon_resource.stun_time
	
var hurt_area : Area2D = null

var delta_health = 0

var knock_back : bool = false
var knock_back_direction : Vector2 = Vector2()
var knock_back_power : float = 0

var stun : bool = false
var stun_time : float = 0

