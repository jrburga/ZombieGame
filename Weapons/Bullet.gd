extends KinematicBody2D
class_name Bullet

var velocity : Vector2 = Vector2(0, 0)
var lifetime = 0.25

func _ready():
	$Timer.start(lifetime)
	var offset = velocity.normalized() * 2
	$RayCast2D.position = -offset 
	$RayCast2D.cast_to = offset

func _physics_process(delta):
	move_and_collide(velocity)
	
	if $RayCast2D.is_colliding():
		global_position = $RayCast2D.get_collision_point()
		var hurt_area = $RayCast2D.get_collider() as Area2D
		$RayCast2D.enabled = false
		hit_hurt_area(hurt_area)
	
func _on_Timer_timeout():
	queue_free()

func hit_hurt_area(hurt_area : Node2D):
	if hurt_area:
		var health_node = hurt_area.owner.find_node("HealthNode") as ValueNode
		if health_node:
			health_node.update_value(-10)
		else:
			push_warning("NO HEALTH NODE ON ZOMBIE")
	velocity = Vector2(0, 0)
	$Bullet.visible = false
	$Timer.start(0.25)
	$CPUParticles2D.emitting = true
	

