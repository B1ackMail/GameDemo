extends Node

@onready var hp当前: TextureProgressBar = $HP/HP当前


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("向左"):
		hp当前.value -= randf_range(10.0, 20.0)
	elif event.is_action_pressed("向右"):
		hp当前.value += randf_range(10.0, 20.0)
