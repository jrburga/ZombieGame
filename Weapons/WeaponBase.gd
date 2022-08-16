extends Node2D
class_name WeaponBase

export(bool) var one_shot = true

onready var bullet_spawner = find_node("BulletSpawner")

var weapon_res : WeaponResource

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.s

func _unhandled_input(event):
	if event is InputEvent:
		if event.is_action_pressed("attack_primary"):
			trigger_primary_pressed()
		if event.is_action_released("attack_primary"):
			trigger_primary_released()
	
var trigger_pressed = false
func trigger_primary_pressed():
	trigger_pressed = true
	while trigger_pressed:
		if bullet_spawner:
			bullet_spawner.spawn_bullets(get_global_mouse_position())
		if one_shot:
			break
		yield(bullet_spawner.find_node("TimerCooldown"), "timeout")

func trigger_primary_released():
	trigger_pressed = false

