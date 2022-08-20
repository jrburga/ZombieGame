extends Area2D

func _ready():
	connect("area_entered", self, "_on_area_entered")
	
func _on_area_entered(area : Area2D):
	print(area.owner)
