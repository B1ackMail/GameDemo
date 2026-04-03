extends Control
class_name CardDrag
#这块就是弹簧函数的相关默认参数，可以修改
var velocity = Vector2.ZERO
var damping = 0.35
var stiffeness = 500

enum CardState {follow,drag} #枚举出两种卡牌的两种状态
@export var cardcurrentstate:CardState = CardState.follow #默认状态为跟随鼠标
@export var follow_target:Node

# 拖拽时的效果参数
var original_rotation: float = 0.0  # 记录拖拽开始时的角度
var drag_scale: Vector2 = Vector2(1.1, 1.1)  # 拖拽时放大到1.1倍
var normal_scale: Vector2 = Vector2(1.0, 1.0)
var scale_velocity: Vector2 = Vector2.ZERO

func _process(delta:float) ->void:
	match cardcurrentstate:
		CardState.drag:
			var target_position = get_global_mouse_position() - size/2
			global_position = global_position.lerp(target_position, 0.4)
			# 拖拽时角度回正为0，并放大（修改父节点Card的旋转）
			get_parent().rotation_degrees = lerp(get_parent().rotation_degrees, 0.0, 0.2)
			get_parent().scale = get_parent().scale.lerp(drag_scale, 0.2)

		CardState.follow:    #这块呢，我用的弹簧函数，目的是让卡牌移动更Q弹，所以我直接问的AI，具体思路我也不晓得
			if follow_target != null:
				var target_position = follow_target.global_position
				var displacement = target_position - global_position
				var force = displacement * stiffeness
				velocity += force * delta
				velocity *= (1.0 - damping)
				global_position += velocity * delta

#这块用了信号，如果要改代码记得上Godot改信号


func _on_button_button_down() -> void:
	cardcurrentstate = CardState.drag
	# 记录父节点Card的当前角度（手牌扇形产生的角度）
	original_rotation = get_parent().rotation_degrees
	# 通知手牌管理器展开相邻卡牌
	_notify_hand_manager(true)
	pass 




func _on_button_button_up() -> void:
	cardcurrentstate = CardState.follow
	# 使用Tween恢复原始角度和缩放
	var tween = get_parent().create_tween()
	tween.parallel().tween_property(get_parent(), "rotation_degrees", original_rotation, 0.15)
	tween.parallel().tween_property(get_parent(), "scale", normal_scale, 0.15)
	# 通知手牌管理器恢复卡牌位置
	_notify_hand_manager(false)
	pass


# 通知手牌管理器当前卡牌状态
func _notify_hand_manager(is_hovered: bool):
	var hand_manager = get_parent().get_parent()
	if hand_manager and hand_manager.has_method("set_hovered_card"):
		if is_hovered:
			var index = hand_manager.get_card_index(get_parent())
			if index != -1:
				hand_manager.set_hovered_card(index)
		else:
			hand_manager.clear_hovered_card() 
