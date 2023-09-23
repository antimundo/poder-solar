extends Control
class_name end_screen

enum end_states { WIN, LOOSE_POLLUTION, LOOSE_ENERGY_OVERCHARGE\
	, LOOSE_ENERGY_OUT }

@onready var title = $Title
@onready var description = $Description
@onready var main_menu = load("res://scenes/main_menu/main_menu.tscn")

func set_state(state: end_states):
	match state:
		end_states.WIN:
			title.text = "¡Victoria!"
			description.text = "Has ganado"
		end_states.LOOSE_ENERGY_OVERCHARGE:
			title.text = "¡Sobrecarga eléctrica!"
			description.text = "Tanta energía ha quemado el tendido eléctrico :("

func _on_button_pressed():
	var this_gameplay_scene = main_menu.instantiate()
	get_tree().root.add_child(this_gameplay_scene)
	queue_free()
