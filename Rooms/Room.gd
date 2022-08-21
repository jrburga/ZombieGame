extends Area2D
class_name RoomArea2D

func activate_room():
	find_node("Light2D").enabled = true
	
func deactivate_room():
	find_node("Light2D").enabled = false
