extends Camera2D
class_name CameraFollow2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var character = owner.find_node("Character2D")
	
	if not character:
		return
		
	var target_position = character.global_position
	
	global_position = lerp(global_position, target_position, 0.1)
