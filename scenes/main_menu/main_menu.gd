extends Control

@onready var gameplay_scene = load("res://scenes/gameplay/gameplay.tscn")

func _on_button_pressed():
	var this_gameplay_scene = gameplay_scene.instantiate()
	get_tree().root.add_child(this_gameplay_scene)
	queue_free()
