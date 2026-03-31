extends TextureProgressBar

@onready var hp当前: TextureProgressBar = $"../HP当前"


func _ready() -> void:
	set_process(false)
	_on_hp当前_changed()

func _on_hp当前_changed() -> void:
	max_value = hp当前.max_value

func _process(delta: float) -> void:	
	if value >= hp当前.value:
		set_process(true)
		value -= max_value  * 0.5 * delta
	elif value < hp当前.value:
		set_process(false)
		value = hp当前.value
		
	
func _on_hp当前_value_changed(_value: float) -> void:
	if value > hp当前.value:
		set_process(true)
	else:
		value = hp当前.value
		set_process(false)
