extends Control
@onready var panel: Panel = $Panel
var tween: Tween

func _on_panel_mouse_entered() -> void:
	# 拖拽时禁用悬停效果
	if panel.cardcurrentstate == panel.CardState.drag:
		return
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(panel,"position",Vector2(0,-25),0.1)
	# 通知手牌管理器展开相邻卡牌
	_notify_hand_manager(true)


func _on_panel_mouse_exited() -> void:
	# 拖拽时禁用悬停效果
	if panel.cardcurrentstate == panel.CardState.drag:
		return
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(panel,"position",Vector2(0,0),0.1)
	# 通知手牌管理器恢复卡牌位置
	_notify_hand_manager(false)


# 通知手牌管理器当前卡牌状态
func _notify_hand_manager(is_hovered: bool):
	var hand_manager = get_parent().get_parent()
	if hand_manager and hand_manager.has_method("set_hovered_card"):
		if is_hovered:
			var index = hand_manager.get_card_index(self)
			if index != -1:
				hand_manager.set_hovered_card(index)
		else:
			hand_manager.clear_hovered_card()
