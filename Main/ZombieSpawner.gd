extends Node2D


export(PackedScene) var ZombieScene
export(NodePath) var PlayAreaRoot
export(float) var delay = 0
export(float) var cooldown = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(delay), "timeout")
	while true:
		spawn_zombie()
		yield(get_tree().create_timer(cooldown), "timeout")

func spawn_zombie():
	if ZombieScene:
		var zombie_child = ZombieScene.instance()
		zombie_child.global_position = global_position
		
		var play_area = get_node(PlayAreaRoot)
		play_area.add_child(zombie_child)
		
