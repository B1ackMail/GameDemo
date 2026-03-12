extends Node
class_name ButtonEffectsModule

@export var ease_type: Tween.EaseType
@export var trans_type: Tween.TransitionType
@export var anim_duration: float = 0.07
@export var scale_amount: Vector2 = Vector2(1.1,1.1)
@export var rotation_amout:float = 3.0
@onready var button: Button = get_parent()

var tween:Tween
func _ready() -> void:
	button.mouse_entered.connect(_on_mouse_hovered.bind(true))
	button.mouse_exited.connect(_on_mouse_hovered.bind(false))
	button.pressed.connect(_on_mouse_hovered)
	button.pivot_offset_ratio = Vector2(0.5,0.5)
	
func _on_mouse_hovered(hovered : bool ) -> void:
	reset_tween()
	tween.tween_property(button, "scale",scale_amount if hovered else Vector2.ONE, anim_duration)
	tween.tween_property(button, "rotation_degrees",rotation_amout *[-1,1].pick_random() if hovered else 0.0, anim_duration)

func _on_button_presssed() -> void:
	reset_tween()
	tween.tween_property(button,"scale",scale_amount,anim_duration).from(Vector2(0.8,0.8))
	tween.tween_property(button,"rotation_degrees",rotation_amout * [1,-1].pick_random(),anim_duration).from(0)


func reset_tween() -> void:
	if tween:
		tween.kill()
	tween = create_tween().set_ease(ease_type).set_trans(trans_type).set_parallel(true)
	
