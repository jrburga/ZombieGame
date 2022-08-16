extends KinematicBody2D


export(float) var speed : float = 10
var character = null
# Called when the node enters the scene tree for the first time.
func _ready():
	character = get_node('/root').find_node('Character2D', true, false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if character:
		var delta_position = character.global_position - global_position
		
		var direction = delta_position.normalized()
		
		var velocity = direction * speed
		
		move_and_slide(velocity)
