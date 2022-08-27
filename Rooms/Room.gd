extends Area2D
class_name RoomArea2D

func _ready():
	add_to_group("rooms")

func activate_room(immediate = false):
	var light = find_node("Light2D")
	

	if immediate:
		light.color = Color.white
		light.enabled = true
		return

	light.color = Color.black
	light.enabled = true
	var tween = create_tween()
	tween.tween_property(light, "color", Color.white, .25)
	
	
func deactivate_room(immediate = false):
	var light = find_node("Light2D")
	
	light.color = Color.white
	
	if immediate:
		light.enabled = false
		return
		
	var tween = create_tween()
	tween.tween_property(light, "color", Color.black, .25)
	tween.tween_property(light, "enabled", false, 0)
