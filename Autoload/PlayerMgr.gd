extends Node

var player : WeakRef = null

static func get_player_mgr(context) -> WeakRef:
	if context:
		return context.get_node('/root/PlayerMgr')
	return null

static func register_player(in_player):
	if in_player:
		get_player_mgr(in_player).player = weakref(in_player)

static func get_player(context):
	return get_player_mgr(context).player.get_ref()
