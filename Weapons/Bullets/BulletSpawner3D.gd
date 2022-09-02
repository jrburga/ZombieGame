tool
extends Spatial
class_name BulletSpawner3D

enum Axis {
	X,
	Y,
	Z
}

export(PackedScene) var BulletScene : PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.editor_hint:
		var bullet_child = BulletScene.instance() as Spatial
		add_child(bullet_child)
		bullet_child.translation = Vector3.ZERO
		print(bullet_child)

func spawn_bullets():
	var bullet_child = BulletScene.instance() as Spatial
	bullet_child.set_as_toplevel(true)
	add_child(bullet_child)
	
