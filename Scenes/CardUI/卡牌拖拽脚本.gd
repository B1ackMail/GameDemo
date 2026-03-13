extends Control

#这块就是弹簧函数的相关默认参数，可以修改
var velocity = Vector2.ZERO
var damping = 0.35
var stiffeness = 500

enum CardState {follow,drag} #枚举出两种卡牌的两种状态
@export var cardcurrentstate:CardState = CardState.follow #默认状态为跟随鼠标
@export var follow_target:Node


func _process(delta:float) ->void:
	match cardcurrentstate:
		CardState.drag:
			var target_position = get_global_mouse_position() - size/2
			global_position = global_position.lerp(target_position, 0.4) 
			
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
	pass 




func _on_button_button_up() -> void:
	cardcurrentstate = CardState.follow
	pass 
