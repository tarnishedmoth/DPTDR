class_name MainRoot extends Node

## Perform any initialization steps,
## Load the main menu.
@export var main_menu_scene:PackedScene
@export var dev_main_menu_scene:PackedScene
@export var load_to_developer_menu:bool = true

var instanced_root: Node

## Called only once at program start.
func _ready() -> void:
	if load_to_developer_menu:
		change_scene(dev_main_menu_scene)
	else:
		change_scene(main_menu_scene)
	
## If there is an active scene, unloads it, then instantiates [param packed_scene] and adds it as a child.
func change_scene(packed_scene: PackedScene) -> void:
	assert(packed_scene)
	assert(packed_scene.can_instantiate())
	
	if instanced_root:
		print_debug("Unloading active scene.")
		# TODO maybe fade to black or something fancy to cover up the scene swap.
		instanced_root.queue_free()
		await instanced_root.tree_exited
		instanced_root = null
	
	var instance = packed_scene.instantiate()
	add_child(instance)
	instanced_root = instance
