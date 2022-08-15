extends KinematicBody2D
class_name Bullet

var velocity : Vector2 = Vector2(0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_collide(velocity * delta)

func _on_Timer_timeout():
	queue_free()
