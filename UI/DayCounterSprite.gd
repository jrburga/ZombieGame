extends Sprite

func _process(delta):
	var daylight_node = DaylightMgr.get_daylight_node(self) as DaylightNode
	
	if daylight_node:
		set_day_num(daylight_node.day_num)
	
func set_day_num(day_num):
	frame = clamp(day_num, 0, 12)
	
	if day_num in [0, 1]:
		$MoonSprite.frame = 0
	if day_num in [2, 3, 4]:
		$MoonSprite.frame = 1
	if day_num in [5, 6, 7]:
		$MoonSprite.frame = 2
	if day_num in [8, 9, 10]:
		$MoonSprite.frame = 3
	if day_num in [11, 12]:
		$MoonSprite.frame = 4
	if day_num >= 13:
		$MoonSprite.frame = 5
	
func get_day_num() -> int:
	return frame + 1
