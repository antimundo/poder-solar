extends Node

@onready var energy_slider = $"../../BottomPanel/EnergySlider"

var max_energy: int = 60
var energy: int = 30

func _ready():
	update_ui()

func add_energy(value: int):
	energy += value
	if energy > max_energy:
		$"../..".load_end_screen(end_screen.end_states.LOOSE_ENERGY_OVERCHARGE)
	elif energy < 0:
		$"../..".load_end_screen(end_screen.end_states.LOOSE_ENERGY_OUT)
	update_ui()

func update_ui():
	$"../../BottomPanel/EnergySlider".max_value = max_energy
	$"../../BottomPanel/EnergySlider".value = energy
