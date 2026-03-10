extends Control
@onready var panel: Panel = $Panel
var tween: Tween

func _on_panel_mouse_entered() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(panel,"position",Vector2(0,-25),0.1)
	pass # Replace with function body.


func _on_panel_mouse_exited() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(panel,"position",Vector2(0,0),0.1)
	pass # Replace with function body.
