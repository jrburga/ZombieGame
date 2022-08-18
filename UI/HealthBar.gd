extends Control
class_name HealthBar

var percent = 100 setget set_percent

func set_percent(value):
	percent = value
	var texture_progress = find_node("TextureProgress") as TextureProgress
	texture_progress.value = percent * texture_progress.max_value
	
	
func _process(delta):
	
	var player = PlayerMgr.get_player(self) as Character2D
	if player:
		var health_node = player.get_health_node()
		set_percent(health_node.get_current_percent())
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
