extends KinematicBody2D
class_name Bullet


var velocity : Vector2 = Vector2(0, 0)
var lifetime = 0.25
var bullet_range = 0
var start_position = Vector2()
var target_position = Vector2()
var damage_details : DamageDetails = null

var destroyed = false

var speed = 0
func _ready():
	var start_position = global_position
	

var distance_traveled = 0
func _physics_process(delta):
	if destroyed:
		return
		
	var prev_pos = global_position
	move_and_collide(velocity)
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
		var health_node = hurt_area.owner.take_damage(damage_details)
	begin_destroy()
	$CPUParticles2D.emitting = true
	

func _on_HitArea2D_area_entered(area):
	print(area, ": ", area.owner)
	$HitArea2D.monitoring = false
	if area.owner is Zombie2D:
		hit_hurt_area(area)


func _on_HitArea2D_body_entered(body):
	$HitArea2D.monitoring = false
	queue_free()
