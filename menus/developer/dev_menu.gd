class_name DeveloperMainMenu extends Control

@export var selectable_levels: Array[PackedScene]

@onready var select_dropdown: OptionButton = %SelectDropdown
@onready var main: Main = get_parent()

@onready var bg: ColorRect = %BG
@onready var launch_guy: Sprite2D = %LaunchGuy
@onready var contents: VBoxContainer = %Contents

func _ready() -> void:
	var id:int = 1 # 0 is reserved for divider.
	for level in selectable_levels:
		if level is PackedScene:
			# Valid array entry
			select_dropdown.add_item(level.resource_path.trim_prefix("res://"), id) # Display text
			select_dropdown.set_item_metadata(id, level.resource_path) # Filepath
			id += 1
			
	Juice.fade_in(contents, Juice.PATIENT, Color.TRANSPARENT)


func _on_launch_button_pressed() -> void:
	var resource:PackedScene = load(select_dropdown.get_item_metadata(select_dropdown.selected))
	
	# Visual effect
	Juice.fade_out(bg, Juice.SNAPPY, Color.BLACK)
	await launch_pic()
	
	# Action
	main.change_scene(resource)

func launch_pic() -> void:
	var tween:Tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(launch_guy, ^"self_modulate", Color.WHITE, 0.4)
	tween.parallel().tween_property(launch_guy, ^"scale", launch_guy.scale * 1.07, 0.46)
	tween.tween_property(launch_guy, ^"self_modulate", Color.BLACK, 0.15).set_ease(Tween.EASE_IN)
	await tween.finished
