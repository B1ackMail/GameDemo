extends Control
class_name MainMenu

@onready var start_button: Button = $MarginContainer/MainLayout/MenuButtons/StartButton
@onready var continue_button: Button = $MarginContainer/MainLayout/MenuButtons/ContinueButton
@onready var settings_button: Button = $MarginContainer/MainLayout/MenuButtons/SettingsButton
@onready var quit_button: Button = $MarginContainer/MainLayout/MenuButtons/QuitButton
@onready var notification_label: Label = $NotificationLabel

const GAME_SCENE_PATH = "uid://d4ccrr84dhvgg"  # CardTest.tscn
const NOTIFICATION_DURATION: float = 2.0

var has_save: bool = false
var notification_tween: Tween

func _ready() -> void:
	start_button.pressed.connect(_on_start_pressed)
	continue_button.pressed.connect(_on_continue_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

	# 初始化提示标签为完全透明
	notification_label.modulate.a = 0.0

	# 检查是否有存档，更新继续游戏按钮状态
	update_continue_button_state()

func update_continue_button_state() -> void:
	has_save = check_has_save_data()
	if not has_save:
		# 无存档时显示为灰色（通过 modulate 实现，保持按钮可点击）
		continue_button.modulate = Color(0.5, 0.5, 0.5, 1)

func check_has_save_data() -> bool:
	# TODO: 后续实现真正的存档检测逻辑
	# 示例：检查存档文件是否存在
	# return FileAccess.file_exists("user://savegame.dat")
	return false

func show_notification(text: String, color: Color = Color(0.9, 0.3, 0.3, 1)) -> void:
	# 停止之前的动画
	if notification_tween and notification_tween.is_valid():
		notification_tween.kill()

	notification_label.text = text
	notification_label.modulate = Color(color.r, color.g, color.b, 0)  # 初始透明
	notification_label.offset_top = -40  # 初始位置（偏下）

	# 淡入 + 上移
	notification_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	notification_tween.tween_property(notification_label, "modulate:a", 1.0, 0.3)
	notification_tween.parallel().tween_property(notification_label, "offset_top", -60, 0.3)

	# 延迟后淡出
	notification_tween.tween_interval(NOTIFICATION_DURATION)
	notification_tween.tween_property(notification_label, "modulate:a", 0.0, 0.5)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file(GAME_SCENE_PATH)

func _on_continue_pressed() -> void:
	if not has_save:
		show_notification("无可用存档")
		return
	# 有存档时：加载存档并进入游戏
	print("加载存档并进入游戏")

func _on_settings_pressed() -> void:
	# 预留：打开设置面板
	print("设置功能待实现")

func _on_quit_pressed() -> void:
	get_tree().quit()
