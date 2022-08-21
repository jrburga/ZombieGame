extends Node

var music_player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	music_player = MusicPlayer.new()
	add_child(music_player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
