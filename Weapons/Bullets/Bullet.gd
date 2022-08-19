extends KinematicBody2D
class_name Bullet


var velocity : Vector2 = Vector2(0, 0)
var lifetime = 0.25
var damage_details : DamageDetails = null

var target_position = Vector2()

var destroyed = false

func _ready():
	$RayCast2D.enabled = false
	$Timer.start(lifetime)
	var offset = velocity.normalized() * 2
	$RayCast2D.position = -offset 
	$RayCast2D.cast_to = offset

func _physics_process(delta):
	if destroyed:
		return
		
	move_and_collide(velocity)
	
	var distance = global_position - target_position

	if distance.length() <= 10:
		$RayCast2D.enabled = true
	elif $RayCast2D.enabled:
		begin_destroy()
		return
	
	if $RayCast2D.is_colliding():
		global_position = $RayCast2D.get_collision_point()
		var hurt_area = $RayCast2D.get_collider() as Area2D
		hit_hurt_area(hurt_area)
		
func begin_destroy():
	destroyed = true
	velocity = Vector2(0, 0)
	$RayCast2D.enabled = false
	$Bullet.visible = false
	$Timer.start(0.25)
	
func _on_Timer_timeout():
	queue_free()

func hit_hurt_area(hurt_area : Node2D):
	if hurt_area:
		damage_details.hurt_area = hurt_area
		var health_node = hurt_area.owner.take_damage(damage_details)
	begin_destroy()
	$CPUParticles2D.emitting = true
	

