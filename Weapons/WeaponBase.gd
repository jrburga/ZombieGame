extends Node2D
class_name WeaponBase

enum {
	IDLE,
	FIRING,
	RELOADING
}

export(bool) var one_shot = true
var trigger_pressed = false
var reloading = false

var state = IDLE

var current_ammo = 0 setget set_current_ammo, get_current_ammo
var ammo_node : ValueNode
onready var bullet_spawner = find_node("BulletSpawner")

var weapon_details : WeaponDetails

# Called when the node enters the scene tree for the first time.
func _ready():
	ammo_node = ValueNode.new() as Node
	ammo_node.name = "AmmoNode"
	add_child(ammo_node)
	ammo_node.min_value = 0
	ammo_node.max_value = 10
	ammo_node.current_value = weapon_details.current_ammo
	ammo_node.connect("on_value_changed", self, "_AmmoNode_on_value_changed")
	
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

	reloading = true
	for frame in range(1, $Sprite.hframes):
		$Sprite.frame = frame
		yield(get_tree().create_timer(.05), "timeout")
	set_current_ammo(10)
	$Sprite.frame = 0
	reloading = false

func trigger_primary_released():
	trigger_pressed = false

