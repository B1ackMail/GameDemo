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

var hovered_index: int = -1  # 当前悬停的卡牌索引
var spread_offset: float = 50.0  # 相邻卡牌让开的距离

func move():
	_update_card_positions(0.1)

# 更新所有卡牌位置，支持悬停时的偏移效果
func _update_card_positions(duration: float = 0.1):
	var center_num = 0
	if card_size % 2 != 0:
		center_num = (card_size - 1) / 2
		for i in card_size:
			var card = control.get_child(i)
			var angle = (i - center_num) * 2
			var offset = Vector2(sin(deg_to_rad(angle + 90)) * angle * 25, -cos(deg_to_rad(angle + 90)) * angle * 15)
			# 如果有悬停的卡牌，计算额外偏移
			if hovered_index != -1:
				offset.x += _calculate_spread_offset(i)
			var target_position = base_pos + offset - card.size / 2
			var tween: Tween = create_tween()
			tween.tween_property(card, "global_position", target_position, duration)
			tween.parallel().tween_property(card, "rotation_degrees", angle, duration)
	else:
		center_num = card_size / 2
		for i in card_size:
			var card = control.get_child(i)
			var angle = (i - center_num) * 2 + 1
			var offset = Vector2(sin(deg_to_rad(angle + 90)) * angle * 25, -cos(deg_to_rad(angle + 90)) * angle * 15)
			# 如果有悬停的卡牌，计算额外偏移
			if hovered_index != -1:
				offset.x += _calculate_spread_offset(i)
			var target_position = base_pos + offset - card.size / 2
			var tween: Tween = create_tween()
			tween.tween_property(card, "global_position", target_position, duration)
			tween.parallel().tween_property(card, "rotation_degrees", angle, duration)

# 计算卡牌i相对于悬停卡牌的偏移量
# 相邻的两张牌让开较多距离，其他牌也让开一点以便看到边
func _calculate_spread_offset(card_index: int) -> float:
	if hovered_index == -1:
		return 0.0

	var distance = card_index - hovered_index

	if distance == 0:
		# 悬停的卡牌本身不移位
		return 0.0
	elif distance == -1:
		# 左侧相邻卡牌往左移
		return -spread_offset
	elif distance == 1:
		# 右侧相邻卡牌往右移
		return spread_offset
	elif distance < -1:
		# 左侧非相邻卡牌，稍微左移一点以便看到边
		return -spread_offset * 0.3
	else:  # distance > 1
		# 右侧非相邻卡牌，稍微右移一点以便看到边
		return spread_offset * 0.3


# 设置悬停的卡牌索引，触发位置更新
func set_hovered_card(index: int):
	if hovered_index != index:
		hovered_index = index
		_update_card_positions(0.15)

# 清除悬停状态
func clear_hovered_card():
	if hovered_index != -1:
		hovered_index = -1
		_update_card_positions(0.15)

# 获取卡牌的索引，如果找不到返回-1
func get_card_index(card: Control) -> int:
	for i in card_size:
		if control.get_child(i) == card:
			return i
	return -1
