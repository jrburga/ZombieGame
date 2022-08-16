extends KinematicBody2D
class_name Bullet

var velocity : Vector2 = Vector2(0, 0)
var max_distance = Vector2(0, 0)
var speed = 100
var target_position = Vector2(0, 0)
var emit_particles = false

var total_distance : float = 0
var total_time : float = 0
func _ready():
	total_distance = (global_position - target_position).length()
	total_time = total_distance / speed if speed > 0 else 0

var pct = 0
var time = 0
var hit = false
func _physics_process(delta):
	
#	move_and_collide(velocity * delta)
	if hit == false:
		pct = time / total_time if total_time > 0 else 0
		global_position = global_position.linear_interpolate(target_position, pct)
		time += delta
	
	if time >= total_time and hit == false:
		$Bullet.visible = false
		$CPUParticles2D.emitting = emit_particles
		hit = true
		$Timer.start(.5)
	
func _on_Timer_timeout():
	queue_free()
