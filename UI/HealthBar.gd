extends Control
class_name HealthBar

var percent = 100 setget _on_pct_set

func _on_pct_set(value):
	percent = value
	var texture_progress = find_node("TextureProgress") as TextureProgress
	texture_progress.value = percent * texture_progress.max_value
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
