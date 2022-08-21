extends Area2D
class_name RoomArea2D

func _ready():
	connect("area_entered", self, "_on_area_entered")
	
func _on_area_entered(area : Area2D):
	if area.owner is Character2D:
		print(area.owner)

func activate_room():
	find_node("Light2D").enabled = true
	
func deactivate_room():
	find_node("Light2D").enabled = false
