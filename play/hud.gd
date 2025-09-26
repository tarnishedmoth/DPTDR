class_name HUD extends Control

@onready var debug_car_display: RichTextLabel = %DebugCarDisplay
@onready var player: Player = %Player

func _process(_delta: float) -> void:
	debug_car_display.text = (
		"Speed " + TextUtils.bold(player.current_speed) + "\n" +
		"Direction " + TextUtils.bold(player.heading) + "\n" +
		"Position " + TextUtils.bold(player.position.snapped(Vector3.ONE*0.1))
	)
