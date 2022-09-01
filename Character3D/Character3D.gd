tool
extends KinematicBody
class_name Character3D

export(float) var scale_correction = sqrt(2.0)
var gravity = Vector3(0, -9.8, 0)
var speed = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$SpriteRoot.scale.y = scale_correction

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
