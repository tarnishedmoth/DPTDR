extends Label

@export var proc_gen_node: Node

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released(&"Regenerate ProcGen"):
		proc_gen_node.generate()
