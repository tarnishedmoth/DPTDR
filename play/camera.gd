extends Camera3D

@export var lerp_weight:float = 0.18

@onready var player: Node3D = %Player
@onready var camera_offset_from_player:Vector3 = player.global_position - global_position

func _process(_delta: float) -> void:
	move_to(player.global_position - camera_offset_from_player)
	

func move_to(target:Vector3, hard:bool = false) -> void:
	if hard:
		global_position = target
	else:
		global_position = global_position.lerp(target, lerp_weight)
