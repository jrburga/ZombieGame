extends Node2D
class_name ZombiesNode

export(bool) var enable_spawners = false setget _enable_spawners

func _enable_spawners(value : bool):
	enable_spawners = value
	for child in get_children():
		if child is ZombieSpawner:
			child.enabled = value

func _ready():
	_enable_spawners(enable_spawners)
	
	var daylight_node = DaylightMgr.async_get_daylight_node(self) as DaylightNode
	if daylight_node == GDScriptFunctionState:
		daylight_node = yield(daylight_node, "completed") as DaylightNode

	daylight_node.connect("day_started", self, "_on_day_started")
	daylight_node.connect("night_started", self, "_on_night_started")
	if daylight_node:
		if daylight_node.time_of_day == DaylightNode.TOD.NIGHT:
			_enable_spawners(true)
			
func _on_day_started():
	kill_all_zombies()
	_enable_spawners(false)
	
func _on_night_started():
	_enable_spawners(true)
	
func kill_all_zombies():
	for child in get_children():
		if child is ZombieSpawner:
			child.kill_spawned_zombies()
