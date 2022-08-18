tool
extends KinematicBody2D
class_name Character2D

export(bool) var local_player = true
export(float) var light_scale = 0.5

export(float) var speed = 10
func _ready():
	var state_machine = $AnimationTree.get("parameters/playback")
#	state_machine.travel("idle_walk")
	
var current_door = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
var velocity : Vector2
func _process(delta):
	if Engine.editor_hint:
		return
		
	$WeaponNode.look_at($WeaponNode.get_global_mouse_position())
	
	$WeaponNode.rotation_degrees = fmod($WeaponNode.rotation_degrees, 360)
	
	var mouse_delta =  $WeaponNode.get_global_mouse_position() - $WeaponNode.global_position
	if mouse_delta.x >= 0:
		$WeaponNode.scale.y = 1
		$SpriteHead.flip_h = false
	else:
		$WeaponNode.scale.y = -1
		$SpriteHead.flip_h = true
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
		$SpriteRoot.scale.x = -1
	if Input.is_action_pressed("right"):
		velocity += Vector2.RIGHT
		$SpriteRoot.scale.x = 1
	
	velocity = velocity.normalized() * speed
	move_and_slide(velocity)
	
	var blend_pos = velocity.normalized().length_squared()
#	$AnimationTree.set("parameters/idle_walk/blend_position", blend_pos)

func _on_InteractionArea_area_entered(area):
	var door = area.get_parent()
	if door:
		current_door = door


func _on_InteractionArea_area_exited(area):
	var door = area.get_parent()
	if door and current_door == door:
		current_door = null
		

