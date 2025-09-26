class_name Main extends Node

## Perform any initialization steps,
## Skip to the Developer Main Menu, or
## Load the splash,
## then load the main menu.

const VERSION:String = "v0.0.2"
const LOG_PREFIX:String = "MAIN:: "

@export var splash_scene:PackedScene
@export var main_menu_scene:PackedScene
@export var dev_main_menu_scene:PackedScene
@export var load_to_developer_menu:bool = true

@export var show_debug_scene_label:bool = true
@export var show_project_version_label:bool = true

var instanced_root: Node

@onready var debug_scene_label: RichTextLabel = %DebugSceneLabel
@onready var project_version_label: Label = %ProjectVersionLabel
@onready var divider: Control = %Divider

## Called only once at program start.
func _ready() -> void:
	project_version_label.text = "v" + get_project_version()
	#if not debug build:
		#debug_scene_label.hide()
	#el
	if show_debug_scene_label:
		debug_scene_label.show()
	else:
		debug_scene_label.hide()
	if show_project_version_label:
		project_version_label.show()
	else:
		project_version_label.hide()
	
	l("DPTDR %s" % [VERSION])
	if load_to_developer_menu:
		change_scene(dev_main_menu_scene)
	else:
		change_scene(splash_scene)
		assert(instanced_root is SplashMenu)
		await instanced_root.finished
		change_scene(main_menu_scene)
	
## If there is an active scene, unloads it, then instantiates [param packed_scene] and adds it as a child.
func change_scene(packed_scene: PackedScene) -> void:
	assert(packed_scene)
	assert(packed_scene.can_instantiate())
	
	if instanced_root:
		l("Unloading active scene.")
		# TODO maybe fade to black or something fancy to cover up the scene swap.
		instanced_root.queue_free()
		await instanced_root.tree_exited
		instanced_root = null
	
	var instance = packed_scene.instantiate()
	add_child(instance)
	instanced_root = instance
	
	var scene_name:String = (
		packed_scene.resource_path.get_base_dir() + "/"
		+ "  [b]"
		+ packed_scene.resource_path.get_file().trim_suffix(".tscn")
		)
	debug_scene_label.text = scene_name
	l("New active scene - loaded %s." % [packed_scene.resource_path])
	
static func get_project_version() -> String:
	return ProjectSettings.get_setting("application/config/version", "v")

static func l(to_print) -> void:
	print(LOG_PREFIX, to_print)
