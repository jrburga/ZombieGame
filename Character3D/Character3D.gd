tool
extends KinematicBody
class_name Character3D

var gravity = Vector3(0, -9.8, 0)
var speed = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


var velocity = Vector3()
func _physics_process(delta):
	if Engine.editor_hint:
		return
		
	var acc = gravity * delta
	
	velocity += acc
	
	var movement = Vector3()
	if Input.is_action_pressed("up"):
		movement += Vector3.FORWARD
	if Input.is_action_pressed("down"):
		movement += Vector3.BACK
	if Input.is_action_pressed("left"):
		movement += Vector3.LEFT
	if Input.is_action_pressed("right"):
		movement += Vector3.RIGHT
		
	velocity += movement.normalized() * speed
	velocity = move_and_slide(velocity)
	velocity.x = 0
	velocity.z = 0
	
	var camera = find_node("Camera") as Camera
	if camera:
		var screen_position = camera.unproject_position($SpriteRoot/GunRoot.global_translation)
		var mouse_position = get_viewport().get_mouse_position()
		var angle_to_mouse = PI-screen_position.angle_to_point(mouse_position)
		print(screen_position, "  --  ", mouse_position)
		$SpriteRoot/GunRoot.rotation.z = angle_to_mouse
		$SpriteRoot/GunRoot2.rotation.y = angle_to_mouse
