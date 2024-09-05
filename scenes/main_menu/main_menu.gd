extends Control

@onready var load_scene = load("res://scenes/gameplay/gameplay.tscn")

func _ready() -> void:
	var current_language = TranslationServer.get_locale()
	if current_language != "en"\
		and current_language != "es"\
		and current_language != "fr":
		TranslationServer.set_locale("es")

func _on_button_pressed() -> void:
	var this_scene = load_scene.instantiate()
	get_tree().root.add_child(this_scene)
	queue_free()

func _on_toggle_language_pressed() -> void:
	match TranslationServer.get_locale():
		"es":
			TranslationServer.set_locale("en")
		"en":
			TranslationServer.set_locale("fr")
		"fr":
			TranslationServer.set_locale("es")
		_:
			TranslationServer.set_locale("es")
