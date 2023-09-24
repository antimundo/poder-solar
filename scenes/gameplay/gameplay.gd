extends Node

@onready var end_scene = load("res://scenes/end_screen/end_scren.tscn")
@onready var slides = $Slides

var current_level: int = 0

func _ready():
	load_slides()

func load_end_screen(end_state: end_screen.end_states):
	var this_scene = end_scene.instantiate()
	get_tree().root.add_child(this_scene)
	this_scene.set_state(end_state)
	queue_free()

func load_level():
	match current_level:
		0:
			pass
		1:
			pass
		2:
			pass

func start_level():
	var moon_tween: Tween = create_tween()
	$Moon.position.x = 75
	moon_tween.tween_property($Moon, "position:x", 750, 60)
	current_level += 1
	await moon_tween.finished
	if current_level >= 3:
		load_end_screen(end_screen.end_states.WIN)
	else:
		load_slides()

func load_slides():
	get_tree().paused = true
	slides.visible = true
	slides.load_first_slide(current_level)
