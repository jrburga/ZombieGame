extends Node2D
class_name ZombieSpawner


export(bool) var enabled = false setget _set_enabled
export(PackedScene) var ZombieScene
export(float) var delay = 0
export(float) var cooldown = 30
export(float) var variance = 3

var _started = false

var spawn_timer

func _set_enabled(value):
	enabled = value
	if enabled:
		start_spawner()
	
func start_spawner():
	if _started:
		return
	_started = true
	if delay > 0:
		yield(get_tree().create_timer(delay), "timeout")
	if not _started:
		return
	if enabled:
		spawn_zombie()
		var rand_variance = randf() * variance
		spawn_timer.start(cooldown + rand_variance)
	
func stop_spawner():
	_started = false
	spawn_timer.stop()
	
func _on_spawn_timer_timeout():
	spawn_zombie()
	if enabled:
		var rand_variance = randf() * variance
		spawn_timer.start(cooldown + rand_variance)
		
# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_timer = Timer.new()
	add_child(spawn_timer)
	spawn_timer.stop()
	spawn_timer.connect("timeout", self, "_on_spawn_timer_timeout")
	if enabled:
		start_spawner()


func spawn_zombie():
	print("spawning zombie")
	if ZombieScene:
		var zombie_child = ZombieScene.instance()
		add_child(zombie_child)
		
func kill_spawned_zombies():
	for child in get_children():
		if child is Zombie2D:
			child.begin_die()
