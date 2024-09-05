extends Node

@onready var slider = $"../../BottomPanel/PollutionSlider"

var max_pollution: int = 50
var pollution: int = 0

func _ready() -> void:
	update_ui()

func add_pollution(value: int) -> void:
	pollution += value
	if pollution > max_pollution:
		$"../..".load_end_screen(end_screen.end_states.LOOSE_POLLUTION)
	elif pollution < 0:
		pollution = 0
	update_ui()

func update_ui() -> void:
	slider.max_value = max_pollution
	slider.value = pollution
