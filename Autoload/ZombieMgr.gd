extends Node

var _zombies_node : WeakRef = null

static func get_zombie_mgr(context : Node):
	if context:
		return context.get_node('/root/ZombieMgr')
	return null

static func register_zombies_node(node : Node):
	get_zombie_mgr(node)._zombies_node = node
	
static func get_zombies_node(context : Node):
	return get_zombie_mgr(context)._zombies_node.get_ref()
