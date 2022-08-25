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
	

static func async_get_daylight_node(context):
	while not get_daylight_mgr(context)._daylight_node.get_ref():
		yield(context.get_tree(), "idle_frame")
	return get_daylight_mgr(context)._daylight_node.get_ref()
		
static func get_daylight_node(context):
	return get_daylight_mgr(context)._daylight_node.get_ref()

