tool
extends KinematicBody2D
class_name Character2D

enum {
	ALIVE,
	DEAD
}

export(bool) var local_player = true
export(float) var light_scale = 0.5

onready var weapon_node = find_node("WeaponNode")

var state = ALIVE

func is_dead():
	return state == DEAD

export(float) var speed = 10
func _ready():
	if Engine.editor_hint:
		return
		
	state = ALIVE
	PlayerMgr.register_player(self)
	$AnimationTree.set('parameters/state/current', ALIVE)
	$HurtArea2D/CollisionShape2D.disabled = false
	$SpriteRoot.modulate.a = 1

#	state_machine.travel("idle_walk")
	
var current_door = null

func get_health_node() -> ValueNode:
	return find_node("HealthNode") as ValueNode

func get_weapon_node() -> WeaponNode:
	return find_node("WeaponNode") as WeaponNode
	
func take_damage(damage_details: DamageDetails):
	if damage_details.knock_back:
		knock_back = damage_details.knock_back_direction * damage_details.knock_back_power
	get_health_node().update_value(damage_details.delta_health)
	$AnimationTree.set('parameters/i_frames/active', true)
	if get_health_node().current_value <= 0:
		begin_die()
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
var velocity : Vector2
var knock_back : Vector2
func _process(delta):
	if Engine.editor_hint:
		return
		
	if state == DEAD:
		return
		
	weapon_node.look_at(weapon_node.get_global_mouse_position())
	
	weapon_node.rotation_degrees = fmod(weapon_node.rotation_degrees, 360)
	
	var mouse_delta =  weapon_node.get_global_mouse_position() - weapon_node.global_position
	if mouse_delta.x >= 0:
		weapon_node.scale.y = 1
		$SpriteRoot/SpriteHead.flip_h = false
	else:
		weapon_node.scale.y = -1
		$SpriteRoot/SpriteHead.flip_h = true
	if Input.is_action_just_pressed("interact"):
		if current_door:
			current_door.toggle_state()
			

		
	velocity = Vector2.ZERO

	if Input.is_action_pressed("up"):
		velocity += Vector2.UP
	if Input.is_action_pressed("down"):
		velocity += Vector2.DOWN
	if Input.is_action_pressed("left"):
		velocity += Vector2.LEFT
		$SpriteRoot/SpriteBody.scale.x = -1
	if Input.is_action_pressed("right"):
		velocity += Vector2.RIGHT
		$SpriteRoot/SpriteBody.scale.x = 1
	
	velocity = velocity.normalized() * speed
	
	if knock_back.length_squared() > 0:
		velocity += knock_back
		knock_back *= .1
	move_and_slide(velocity)

func _on_InteractionArea_area_entered(area):
	var door = area.owner
	if door:
		current_door = door


func _on_InteractionArea_area_exited(area):
	var door = area.owner
	if door and current_door == door:
		current_door = null
		
		
func begin_die():
	state = DEAD
	$AnimationTree.set('parameters/state/current', DEAD)

