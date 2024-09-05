extends Control
class_name end_screen

enum end_states { WIN, LOOSE_POLLUTION, LOOSE_ENERGY_OVERCHARGE\
	, LOOSE_ENERGY_OUT }

@onready var title = $Title
@onready var description = $Description
@onready var main_menu = load("res://scenes/main_menu/main_menu.tscn")
@onready var image: TextureRect = $Image
@onready var music = $Music

func set_state(state: end_states) -> void:
	match state:
		end_states.WIN:
			title.text = tr("victory_title")
			description.text = tr("victory_description")
			image.set_texture(load("res://sprites/slides/win.jpg"))
			music.stream = load("res://sounds/Frédéric Lardon - Cellphone - 05 funk à 10 balles.ogg")
		end_states.LOOSE_ENERGY_OVERCHARGE:
			title.text = tr("loose_energy_overcharge_title")
			description.text = tr("loose_energy_overcharge_description")
			image.set_texture(load("res://sprites/slides/fire.jpg"))
		end_states.LOOSE_POLLUTION:
			title.text = tr("loose_pollution_title")
			description.text = tr("loose_pollution_description")
			image.set_texture(load("res://sprites/slides/pollution.jpg"))
		end_states.LOOSE_ENERGY_OUT:
			title.text = tr("loose_energy_out_title")
			description.text = tr("loose_energy_out_description")
			image.set_texture(load("res://sprites/slides/lights_out.jpg"))
	music.play()

func _on_button_pressed() -> void:
	var this_gameplay_scene = main_menu.instantiate()
	get_tree().root.add_child(this_gameplay_scene)
	queue_free()
