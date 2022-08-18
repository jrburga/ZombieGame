extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	return
	
func _process(delta):
	var player = PlayerMgr.get_player(self) as Character2D
	
	if player:
		var weapon_node = player.get_weapon_node() as WeaponNode
		var weapon = weapon_node.get_weapon() as WeaponBase
		
		text = str(weapon.current_ammo) + "/" + str(weapon.max_ammo)
