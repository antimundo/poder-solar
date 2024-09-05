extends Node

@onready var slider = $"../../BottomPanel/EnergySlider"

var max_energy: int = 50
var energy: int = 35

func _ready() -> void:
	update_ui()

func add_energy(value: int) -> void:
	energy += value
	if energy > max_energy:
		$"../..".load_end_screen(end_screen.end_states.LOOSE_ENERGY_OVERCHARGE)
	elif energy < 0:
		$"../..".load_end_screen(end_screen.end_states.LOOSE_ENERGY_OUT)
	update_ui()

func update_ui() -> void:
	slider.max_value = max_energy
	slider.value = energy
