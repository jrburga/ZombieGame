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

func _physics_process(delta):
	if dying:
		return
		
	if character:
		var delta_position = character.global_position - global_position
		var direction = delta_position.normalized()
		var velocity = direction * speed
		move_and_slide(velocity)

func begin_die():
	dying = true
	for n in range(10):
		modulate.a *= .8
		yield(get_tree().create_timer(.1), "timeout")
	queue_free()
	
func take_damage(delta):
	$HealthNode.update_value(delta)

func _on_HealthNode_current_value_changed(prev_value, current_value, value_node):
	if current_value == 0:
		begin_die()
