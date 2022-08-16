extends Node2D
class_name BulletSpawner

export(PackedScene) var BulletScene : PackedScene
export(float) var bullet_speed = 300
export(float) var bullet_lifetime = 0.25
export(int) var bullets_spawned = 1
export(float) var seconds_per_bullet = 0
export(float) var spread = 0
export(float) var cooldown = 0

var weapon_res : WeaponResource

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

var firing = false
func spawn_bullets(target_position : Vector2):
	if firing:
		return
	firing = true
	if $TimerCooldown.time_left > 0:
		return
	
	for index in bullets_spawned:
		var bullet = BulletScene.instance() as Bullet
		bullet.lifetime = bullet_lifetime
		bullet.global_position = global_position
		var delta = target_position - owner.global_position
		var direction = delta.normalized()
		
		var angle_deg = 2 * randf() * spread - spread
		var angle_rad = deg2rad(angle_deg)
		
		direction = direction.rotated(angle_rad)
		
		bullet.velocity = direction * bullet_speed
		
		get_node('/root').add_child(bullet)
		
		if seconds_per_bullet > 0:
			$TimerAutoFire.start(seconds_per_bullet)
			yield($TimerAutoFire, "timeout")
		
	firing = false
	if cooldown > 0:
		$TimerCooldown.start(cooldown)

