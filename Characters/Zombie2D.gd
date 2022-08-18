extends KinematicBody2D


export(float) var speed : float = 10
var character = null
var dying = false
# Called when the node enters the scene tree for the first time.
func _ready():
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
		var velocity = knock_back
		move_and_slide(velocity)
		knock_back *= .1
		return
		
	if character:
		var delta_position = character.global_position - global_position
		var direction = delta_position.normalized()
		var velocity = direction * speed
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
	$HealthNode.update_value(damage_details.delta_health)
	
	if damage_details.knock_back:		
		knock_back = damage_details.knock_back_direction * damage_details.knock_back_power

		

func _on_HealthNode_current_value_changed(prev_value, current_value, value_node):
	if current_value == 0:
		begin_die()
