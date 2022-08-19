tool
extends AudioStreamPlayer
class_name MusicPlayer

export(bool) var reimport_markers = false setget _on_reimport_markers

var markers = {}

func _on_reimport_markers(value):
	if value:
		_reimport_markers()

func _reimport_markers():
	var file = File.new()
	file.open("res://Audio/zombie_contra_markers.txt", file.READ)
	var header = file.get_csv_line() as PoolStringArray
	
	markers = {}
	while file.is_open() and !file.eof_reached():
		var line = file.get_csv_line() as PoolStringArray
		if line.size() != header.size():
			continue
		var section_name = line[1]
		var section_time = line[2]
		var minutes = float(section_time.split(':')[0])
		var seconds = float(section_time.split(':')[1])
		markers[section_name] = minutes * 60 + seconds
		
	print(markers)

# Called when the node enters the scene tree for the first time.
func _ready():
	return
	
	_reimport_markers()
	
	play(markers['section_1_loop'])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	return 
	if Engine.editor_hint:
		return
	
	var bps = 120 / 60
	var loop_seconds = markers['section_1_loop'] +  4 / bps
	var time = get_playback_position() + AudioServer.get_time_since_last_mix() - AudioServer.get_output_latency()
	
	if time >= loop_seconds:
		seek(markers['section_1_loop'])
