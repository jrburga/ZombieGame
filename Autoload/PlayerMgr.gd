extends Node

var player : WeakRef = null

static func get_player_mgr(context) -> WeakRef:
	if context:
		return context.get_node('/root/PlayerMgr')
	return null

static func register_player(player):
	if player:
		get_player_mgr(player).player = weakref(player)

static func get_player(context):
	return get_player_mgr(context).player.get_ref()
