extends KinematicBody2D
class_name Bullet


var velocity : Vector2 = Vector2(0, 0)
var lifetime = 0.25
var bullet_range = 0.0
var damage_details : DamageDetails = null

var destroyed = false

func _ready():
	$RayCast2D.set_as_toplevel(true)

var speed = 0.0
var distance_traveled = 0
func _physics_process(delta):
	if destroyed:
		return
		
	var prev_pos = global_position
	move_and_collide(velocity * delta)
	var new_pos = global_position
	
	distance_traveled += (new_pos - prev_pos).length()
	
	if distance_traveled > bullet_range:
		begin_destroy()
		return
		
func begin_destroy():
	destroyed = true
	velocity = Vector2(0, 0)
	$Bullet.visible = false
	$Timer.start(0.25)
	
func _on_Timer_timeout():
	queue_free()

func hit_hurt_area(hurt_area : Node2D):
	if hurt_area:
		damage_details.hurt_area = hurt_area
		hurt_area.owner.take_damage(damage_details)
	begin_destroy()
	$CPUParticles2D.emitting = true

func _can_collide_with(area):
	if area == null:
		return false
	if not area.owner is Zombie2D:
		return
		
	$RayCast2D.global_position = global_position
	$RayCast2D.cast_to = area.owner.global_position - global_position
	$RayCast2D.force_raycast_update()
	return $RayCast2D.get_collider() == area.owner

func _on_HitArea2D_area_entered(area):
	if not _can_collide_with(area):
		return
	
	set_deferred("monitoring", false)
	if area.owner is Zombie2D:
		hit_hurt_area(area)


func _on_HitArea2D_body_entered(body):
	set_deferred("monitoring", false)
	queue_free()
