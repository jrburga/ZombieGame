extends KinematicBody2D
class_name Zombie2D

enum {
	IDLE,
	CHASING,
	FLEEING,
	ATTACKING,
	STUNNED
}


var zombie_navigation : Navigation2D = null
var path = null
var player_found = false
var state = IDLE
export(float) var speed : float = 10

var dying = false
# Called when the node enters the scene tree for the first time.
func _ready():
	zombie_navigation = find_navigation()

func navigate():
	var velocity = Vector2()
	if path.size() > 1:
		velocity = global_position.direction_to(path[1]) * speed
		
		var dist_to_path : Vector2 = (path[0] - global_position)
		if dist_to_path.is_equal_approx(Vector2(0, 0)):
			path.remove(0)
	return velocity
		

func generate_path(player_position):
	if zombie_navigation:
		path = zombie_navigation.get_simple_path(global_position, player_position, false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func find_navigation():
	for navigation_node in get_tree().get_nodes_in_group('navigation'):
		return navigation_node
	return null

func find_closest_window():
	var closest_dist = INF
	var closest_window = null
	for window in get_tree().get_nodes_in_group('windows'):
		var dist = (window.global_position - global_position).length()
		if dist < closest_dist:
			closest_window = window
			closest_dist = dist
	return closest_window

var knock_back = Vector2()

var regenerate_seconds = 0
var regenerate_wait_time = 2
func _physics_process(delta):
	
	regenerate_seconds = min(0, regenerate_seconds - delta)
	var character = PlayerMgr.get_player(self)
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
		
	if is_instance_valid(character):
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
				
		var velocity = Vector2()
		if zombie_navigation:
			if regenerate_seconds <= 0:
				generate_path(character.global_position)
				regenerate_seconds = regenerate_wait_time
			velocity = navigate()
		else:
			var direction = distance.normalized()
			velocity = direction * speed
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
