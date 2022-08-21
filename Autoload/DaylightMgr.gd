extends Node

var _daylight_node : WeakRef
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

static func get_daylight_mgr(context):
	if context:
		return context.get_node('/root/DaylightMgr')
	return null
	
static func register_daylight_node(node):
	get_daylight_mgr(node)._daylight_node = weakref(node)
	
static func get_daylight_node(context):
	get_daylight_mgr(context)._daylight_node.get_ref()

