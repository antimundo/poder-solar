extends Control

@onready var load_scene = load("res://scenes/gameplay/gameplay.tscn")

func _on_button_pressed():
	var this_scene = load_scene.instantiate()
	get_tree().root.add_child(this_scene)
	queue_free()
