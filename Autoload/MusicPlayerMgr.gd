extends Node

var music_player : AudioStreamPlayer = null
var fade_tween : Tween = null

export(float) var volume = 1
var song_length = 120

var zombie_music = preload("res://Audio/zombie_music.mp3")
var zombi_lvl_1 = preload("res://Audio/zombi_double_bass.mp3")
var zombi_lvl_2 = preload("res://Audio/zombi_hard_metal.mp3")
var zombi_lvl_3 = preload("res://Audio/zombi_metal.mp3")
var zombi_lvl_4 = preload("res://Audio/zombi_contra.mp3")

var songs = [
	zombie_music,
	zombi_lvl_1,
	zombi_lvl_2,
	zombi_lvl_3,
	zombi_lvl_4
]
# Called when the node enters the scene tree for the first time.
func _ready():
	
	music_player = AudioStreamPlayer.new()
	fade_tween = Tween.new()
	add_child(music_player)
	add_child(fade_tween)
	
	print(zombie_music)
	
	music_player.stream = zombie_music
	music_player.play()
	
	music_player.volume_db = 0
	
	var song_length = music_player.stream.get_length() - 6
	while true:
		yield(get_tree().create_timer(song_length), "timeout")
		play_next_song()
		yield(get_tree().create_timer(20), "timeout")

var song_idx = 0
func pop_next_song():
	song_idx = (song_idx + 1) % songs.size()
	
	return songs[song_idx]

enum FADE {
	NONE,
	IN,
	OUT
}

var fade = FADE.NONE
var fade_time = 3
var fade_seconds = 0

func _process(delta):
	
	if fade == FADE.NONE:
		return
		
		
	if fade_time == 0:
		music_player.volume_db = 0
		fade = FADE.NONE
		return
		
	var fade_pct = range_lerp(fade_seconds, 0, fade_time, 0, 1)
	if fade_pct >= 1:
		fade = FADE.NONE
		return
		
	if fade == FADE.OUT:
		fade_pct = 1 - fade_pct
		
	var target_volume_db =  range_lerp(fade_pct, 0, 1, -80, 0)
	music_player.volume_db = target_volume_db
	
	fade_seconds += delta

func play_next_song():

	fade_seconds = 0
	fade_time = 6
	fade = FADE.OUT
	yield(get_tree().create_timer(fade_time), "timeout")
	music_player.playing = false
	music_player.stream = pop_next_song()
	music_player.playing = true
	fade_seconds = 0
	fade_time = 0
	fade = FADE.IN
	
