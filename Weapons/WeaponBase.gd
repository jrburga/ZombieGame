extends Node2D
class_name WeaponBase

enum {
	IDLE,
	FIRING,
	RELOADING
}

export(bool) var one_shot = true
var trigger_pressed = false

var state = IDLE

var current_ammo = 0 setget set_current_ammo, get_current_ammo
var ammo_node : ValueNode
onready var bullet_spawner = find_node("BulletSpawner")

var weapon_details : WeaponDetails

func get_weapon_resource() -> WeaponResource:
	return weapon_details.weapon_resource as WeaponResource if weapon_details else null
	
# Called when the node enters the scene tree for the first time.
func _ready():
	var weapon_res = get_weapon_resource()
	assert(weapon_res)
	
	one_shot = not weapon_res.automatic
	
	ammo_node = ValueNode.new() as ValueNode
	ammo_node.min_value = 0
	ammo_node.max_value = weapon_res.magazine_size
	ammo_node.current_value = weapon_details.current_ammo
	print(ammo_node.max_value)
	ammo_node.name = "AmmoNode"
	add_child(ammo_node)
	
	ammo_node.connect("current_value_changed", self, "_AmmoNode_on_value_changed")
	
	update_bullet_spawner()
	
func update_bullet_spawner():
	var weapon_res = get_weapon_resource()
	var bullet_spawner = find_node("BulletSpawner") as BulletSpawner
	if bullet_spawner:
		bullet_spawner.bullet_speed = weapon_res.bullet_speed
		bullet_spawner.bullet_lifetime = weapon_res.bullet_lifetime
		bullet_spawner.bullets_spawned = weapon_res.bullets_spawned
		bullet_spawner.spread = weapon_res.bullet_spread
		bullet_spawner.cooldown = weapon_res.cooldown
	
func set_current_ammo(value):
	print('update ammo: ', value)
	if ammo_node:
		ammo_node.current_value = value
	
	if weapon_details:
		weapon_details.current_ammo = value
		
func get_current_ammo():
	if ammo_node:
		return ammo_node.current_value
		
	if weapon_details:
		return weapon_details.current_ammo
	return 0
	
func _AmmoNode_on_value_changed(prev_value, new_value, value_node):
	weapon_details.current_ammo = new_value

func _unhandled_input(event):
	if event is InputEvent:
		if event.is_action_pressed("attack_primary"):
			trigger_primary_pressed()
		if event.is_action_released("attack_primary"):
			trigger_primary_released()
		if event.is_action_pressed("weapon_reload"):
			reload_pressed()
	

func trigger_primary_pressed():
	trigger_pressed = true
	
	if state != IDLE:
		return
		
	if get_current_ammo() == 0:
		return
		
	update_bullet_spawner()
	while trigger_pressed:
		state = FIRING
		if bullet_spawner:
			bullet_spawner.spawn_bullets(get_global_mouse_position())
			
			set_current_ammo(get_current_ammo() - 1)
		if one_shot:
			break
			
		if get_current_ammo() == 0:
			break
			
		yield(bullet_spawner.find_node("TimerCooldown"), "timeout")
		
	state = IDLE
		
func reload_pressed():
	if state != IDLE:
		return

	state = RELOADING
	$AnimationPlayer.play("reload")
	yield($AnimationPlayer, "animation_finished")
	set_current_ammo(get_weapon_resource().magazine_size)
	$Sprite.frame = 0
	state = IDLE

func trigger_primary_released():
	trigger_pressed = false

