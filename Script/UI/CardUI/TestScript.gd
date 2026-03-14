extends Control
class_name CardScript
const CARD = preload('res://Scenes/card.tscn')
@onready var control: Control = $Control
@onready var button: Button = $Button
var Target_position:Vector2
var base_pos = Vector2(DisplayServer.window_get_size().x / 2.0,DisplayServer.window_get_size().y - 200)
var card_size:int = 0;
#卡牌添加脚本
func _on_button_pressed() -> void:
	add_card()

func add_card():
	var new_card = CARD.instantiate()
	control.add_child(new_card)
	new_card.global_position = button.global_position
	card_size += 1
	await get_tree().create_timer(0.1).timeout
	move()

func move():
	var center_num = 0
	if card_size % 2 !=0:
		center_num = (card_size - 1) /2
		for i in card_size:
			var card = control.get_child(i)
			var angle = (i - center_num) * 2
			var offset = Vector2(sin(deg_to_rad(angle + 90)) * angle * 25 ,-cos(deg_to_rad(angle +90)) * angle * 15)
			var target_position = base_pos + offset  - card.size /2
			var tween:Tween = create_tween()
			tween.tween_property(card,"global_position",target_position,0.1)
			tween.parallel().tween_property(card,"rotation_degrees",angle,0.1)
			
	else:
		center_num = card_size/2
		for i in card_size:
			var card = control.get_child(i)
			var angle = (i - center_num) * 2 + 1
			var offset = Vector2(sin(deg_to_rad(angle + 90)) * angle * 25 ,-cos(deg_to_rad(angle + 90)) * angle * 15)
			var target_position = base_pos + offset - card.size /2
			var tween:Tween = create_tween()
			tween.tween_property(card,"global_position",target_position,0.1)
			tween.parallel().tween_property(card,"rotation_degrees",angle,0.1)
