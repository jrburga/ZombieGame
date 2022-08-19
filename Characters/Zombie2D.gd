extends KinematicBody2D

enum {
	IDLE,
	CHASING,
	ATTACKING,
	STUNNED
}

var state = IDLE
export(float) var speed : float = 10
var character = null
var dying = false
# Called when the node enters the scene tree for the first time.
func _ready():
	find_node('HitArea2D').find_node('CollisionShape2D').disabled = true
	character = get_node('/root').find_node('Character2D', true, false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var knock_back = Vector2()
func _physics_process(delta):
	if dying:
		return
		
	if knock_back.length_squared() > 0:
		if state == ATTACKING:
			$AnimationPlayer.seek(0)
			$AnimationPlayer.stop()
			
		var velocity = knock_back
		move_and_slide(velocity)
		knock_back *= .1
		state = STUNNED
		
		return
		
		

	if character:
		var distance = character.global_position - global_position
		if state == ATTACKING:
			$HandsRoot.rotation = distance.angle()
			$HandsRoot.rotation_degrees = fmod($HandsRoot.rotation_degrees, 360)
		else:
			if distance.x >= 0:
				$HandsRoot.rotation = 0
			else:
				$HandsRoot.rotation_degrees = 180
		if distance.x >= 0:
			$HandsRoot.scale.y = 1
		else:
			$HandsRoot.scale.y = -1
		if distance.length() < 10:
			if state != ATTACKING:
				attack()
				return
		
		var direction = distance.normalized()
		var velocity = direction * speed
		if velocity.x < 0:
			$SpriteRoot.scale.x = -1
		else:
			$SpriteRoot.scale.x = 1
		move_and_slide(velocity)
		return

func begin_die():
	dying = true
	$HurtAreaBody2D/CollisionShape2D.disabled = true
	$HurtAreaHead2D/CollisionShape2D.disabled = true
	for n in range(10):
		modulate.a *= .8
		yield(get_tree().create_timer(.1), "timeout")
	queue_free()
	
func take_damage(damage_details : DamageDetails):
	var damage_multiplier = 1
	if $HurtAreaHead2D == damage_details.hurt_area:
		damage_multiplier = 5
	$HealthNode.update_value(damage_details.delta_health * damage_multiplier)
	
	if damage_details.knock_back:		
		knock_back = damage_details.knock_back_direction * damage_details.knock_back_power

func attack():
	if state == STUNNED:
		return
	$AnimationPlayer.play("attack_0")
	state = ATTACKING
	yield($AnimationPlayer, "animation_finished")
	state = IDLE

func _on_HealthNode_current_value_changed(prev_value, current_value, value_node):
	if current_value == 0:
		begin_die()


func _on_HitArea2D_area_entered(area):
	var damage_details = DamageDetails.new()
	damage_details.hurt_area = area
	damage_details.delta_health = -10
	damage_details.knock_back = true
	
	var angle = $HandsRoot.rotation
	damage_details.knock_back_direction = Vector2(cos(angle), sin(angle))
	damage_details.knock_back_power = 100
	if area.owner.has_method('take_damage'):
		area.owner.take_damage(damage_details)
