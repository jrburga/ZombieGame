tool
extends KinematicBody2D
class_name Character2D

export(bool) var local_player = true
export(float) var light_scale = 0.5

export(float) var speed = 10
func _ready():
	var state_machine = $AnimationTree.get("parameters/playback")
	state_machine.travel("idle_walk")
	
var current_door = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
var velocity : Vector2
func _process(delta):
	if find_node("LightEnvironment"):
		$LightEnvironment.texture_scale = light_scale
	
	if local_player:
		$Sprite.light_mask = 0b100
		if find_node("LightCharacter"):
			$LightCharacter.enabled = true
	else:
		$Sprite.light_mask = 0b001
		if find_node("LightCharacter"):
			$LightCharacter.enabled = false

	
	if Engine.editor_hint:
		return
		
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
		$Sprite.flip_h = true
	if Input.is_action_pressed("right"):
		velocity += Vector2.RIGHT
		$Sprite.flip_h = false
	
	velocity = velocity.normalized() * speed
	move_and_slide(velocity)
	
	var blend_pos = velocity.normalized().length_squared()
	$AnimationTree.set("parameters/idle_walk/blend_position", blend_pos)
	
	


func _on_InteractionArea_area_entered(area):
	var door = area.get_parent()
	if door:
		current_door = door


func _on_InteractionArea_area_exited(area):
	var door = area.get_parent()
	if door and current_door == door:
		current_door = null
