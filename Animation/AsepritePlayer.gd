tool
extends AnimationPlayer
class_name AespritePlayer

export(bool) var reimport_json = false setget _on_reimport_json
export(bool) var display_animation = false setget _on_display_animation

func _on_display_animation(value):
	if value:
		var animation = get_animation('reload')
		
		print(animation.track_get_path(0))
		

func _on_reimport_json(value):
	if value:
		_reimport_reload_animation()
		
func _reimport_reload_animation():
	var owner_sprite = owner.find_node("Sprite") as Sprite
	var path = owner_sprite.texture.resource_path
	var json_file = path.get_file().split('.')[0].split('-')[0] + '.json'
	var json_path = path.get_base_dir() + '/JSON/' + json_file
	var data = Aseprite.read_json(json_path)
	
	var animation : Animation = null
	if get_animation('reload'):
		animation = get_animation('reload')
		animation.clear()
	else:
		animation = Animation.new()
		add_animation('reload', animation)
		
	
	var track_idx = animation.add_track(Animation.TYPE_VALUE)
	animation.track_set_path(0, NodePath("Sprite:frame"))
	var time = 0
	var duration = 0
	var frame_index = 0
	for frame in data.frames:
		print(data.frames[frame])
		duration = data.frames[frame].duration / 1000.0
		animation.track_insert_key(0, time, frame_index)
		time += duration
		frame_index += 1
	animation.length = time
	
