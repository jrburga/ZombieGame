tool
extends KinematicBody2D
class_name Zombie2D

enum Level {
	LVL0,
	LVL1,
	LVL2,
	LVL3,
	LVL4,
	LVL5,
	LVL6
}

enum {
	IDLE,
	CHASING,
	FLEEING,
	ATTACKING,
	STUNNED
}

onready var sprite_head = find_node("SpriteHead")
onready var sprite_body = find_node("SpriteBody")
onready var sprite_hand_back = find_node("SpriteHandBack")
onready var sprite_hand_front = find_node("SpriteHandFront")

onready var navigation_agent : NavigationAgent2D = find_node("NavigationAgent2D")

var zombie_navigation : Navigation2D = null
var path = null
var player_found = false
var state = IDLE
export(Level) var zombie_level = Level.LVL0
export(float) var speed : float = 10

var dying = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.editor_hint:
		return
		
	
	var daylight_node = DaylightMgr.get_daylight_node(self) as DaylightNode
	if daylight_node:
		var factor = pow(1.08, daylight_node.day_num)
		$HealthNode.max_value = 50 * factor
		$HealthNode.current_value = $HealthNode.max_value
		
		var speed_factor = pow(1.05, daylight_node.day_num)
		speed = speed * speed_factor
		
		var daylight_zombie_level = range_lerp(daylight_node.day_num, 0, 12, 0, 6) 
		_set_zombie_level(daylight_zombie_level)
	zombie_navigation = find_navigation()
	navigation_agent.set_navigation(zombie_navigation)
	var character = PlayerMgr.get_player(self)
	if character:
		navigation_agent.set_target_location(character.global_position)

func navigate():
	var velocity = Vector2()
	if path.size() > 1:
		velocity = global_position.direction_to(path[1]) * speed
		
		var dist_to_path : Vector2 = (path[0] - global_position)
		if dist_to_path.length() < 3:
			path.remove(0)
	return velocity
		

func generate_path(player_position):
	if zombie_navigation:
		path = zombie_navigation.get_simple_path(global_position, player_position, false)

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta : float):
	if Engine.editor_hint:
		_set_zombie_level(zombie_level)

			
func _set_zombie_level(level):
	zombie_level = level
	var zombie_texture_path = "res://Textures/Zombies/harder_zombies%d.png" % (zombie_level + 1)
	sprite_head = find_node("SpriteHead")
	sprite_body = find_node("SpriteBody")
	sprite_hand_back = find_node("SpriteHandBack")
	sprite_hand_front = find_node("SpriteHandFront")
	var atlas = load(zombie_texture_path)
	for sprite_part in [sprite_head, sprite_body, sprite_hand_back, sprite_hand_front]:
		var atlas_texture = sprite_part.texture as AtlasTexture
		atlas_texture.atlas = atlas
		

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
var regenerate_wait_time = 0

var last_target_location = Vector2()
func _physics_process(delta):
	if Engine.editor_hint:
		return
		
	regenerate_seconds = max(0, regenerate_seconds - delta)
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
		
	state = IDLE
		
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
		
#		if !last_target_location.is_equal_approx(character.global_position):
		navigation_agent.set_target_location(character.global_position)
#		print(navigation_agent.get_nav_path())
		last_target_location = character.global_position

		var direction = global_position.direction_to(navigation_agent.get_next_location())
		
		velocity = direction * speed
		navigation_agent.set_velocity(velocity)
		
		if velocity.x < 0:
			$SpriteRoot.scale.x = -1
		else:
			$SpriteRoot.scale.x = 1
			
		# movement is done in self._on_NavigationAgent2D_velocity_computed
		# move_and_slide(velocity)

func begin_die():
	dying = true
	$HurtAreaBody2D/CollisionShape2D.set_deferred("disabled", true)
	$HurtAreaHead2D/CollisionShape2D.set_deferred("disabled", true)

	
	$CollisionShape2D.set_deferred("disabled", true)
	
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1, 1, 1, 0), .5)
	tween.tween_callback(self, "queue_free")
	
func take_damage(damage_details : DamageDetails):
	var damage_multiplier = 1
#	if $HurtAreaHead2D == damage_details.hurt_area:
#		damage_multiplier = 5
	$HealthNode.update_value(damage_details.delta_health * damage_multiplier)
	
	if damage_details.knock_back:		
		knock_back = damage_details.knock_back_direction * damage_details.knock_back_power

func attack():

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


func _on_NavigationAgent2D_velocity_computed(safe_velocity):
	move_and_slide(safe_velocity)
