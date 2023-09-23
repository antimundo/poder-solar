extends Node

@onready var end_scene = load("res://scenes/end_screen/end_scren.tscn")

func load_end_screen(end_state: end_screen.end_states):
	var this_scene = end_scene.instantiate()
	get_tree().root.add_child(this_scene)
	this_scene.set_state(end_state)
	queue_free()
