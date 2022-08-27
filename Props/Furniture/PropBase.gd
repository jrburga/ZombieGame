extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	var navigation_obstacle = find_node("NavigationObstacle2D")
	if navigation_obstacle == null:
		navigation_obstacle = NavigationObstacle2D.new()
		add_child(navigation_obstacle)
	if navigation_obstacle:
		for navigation_node in get_tree().get_nodes_in_group("navigation"):
			navigation_obstacle.set_navigation(navigation_node)
			return

	for navigation_node in get_tree().get_nodes_in_group("navigation"):
		Navigation2DServer.agent_set_map(navigation_obstacle.get_rid(), navigation_node.get_rid())

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
