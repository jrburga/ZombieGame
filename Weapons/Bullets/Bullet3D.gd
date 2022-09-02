extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed : float = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().create_timer(10).connect("timeout", self, "_on_timeout")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _physics_process(delta):
	var velocity = transform.basis.x * speed
	move_and_slide(velocity)
	var collision = get_last_slide_collision()
	if collision:
		queue_free()
	
func _on_timeout():
	queue_free()
