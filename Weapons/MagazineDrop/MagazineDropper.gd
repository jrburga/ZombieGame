extends Sprite

export(PackedScene) var MagazineDropScene

func spawn_magazine_drop():
	if MagazineDropScene:
		var mag_drop = MagazineDropScene.instance()
		
		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
