extends CharacterBody3D

#告诉系何时播放玩家动画
@onready var sprite: AnimatedSprite3D = $AnimatedSprite3D
var current_animation:= "角色站立"



#设置玩家初始移动参数
@export var speed: float = 5.0    #移动
@export var jump_velocity:float = 4.5   #跳跃
@export var gravity: float = 15.0     #重力



func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta   #如果不在地面上，应用重力
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity    #如果按下跳跃键并且在地面上，设置跳跃速度


	#WASD控制玩家移动
	var move_direction = Vector3.ZERO
	#获取摄影机位置
	var cam = get_viewport().get_camera_3d()
	var forward = -cam.global_transform.basis.z 
	var right = cam.global_transform.basis.x
	forward.y = 0
	right.y = 0
	forward = forward.normalized()
	right = right.normalized()


	#地图输入
	if Input.is_action_pressed("向上"):
		move_direction += forward 
	if Input.is_action_pressed("向下"):
		move_direction -= forward
	if Input.is_action_pressed("向左"):
		move_direction -= right
	if Input.is_action_pressed("向右"):
		move_direction += right

	#此处为归一化处理，使得玩家斜向移动速度不会突变
	if move_direction != Vector3.ZERO:
		move_direction = move_direction.normalized()

	velocity.x = move_direction.x * speed
	velocity.z = move_direction.z * speed


	move_and_slide()

	#根据玩家输入切换动画
	var anim_to_play = "角色站立"

	if Input.is_action_pressed("向上") or Input.is_action_pressed("向下") or Input.is_action_pressed("向左") or Input.is_action_pressed("向右"):
		anim_to_play = "角色行走"
	
	if current_animation != anim_to_play:
		sprite.play(anim_to_play)
		current_animation = anim_to_play

	
