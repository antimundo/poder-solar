extends Control

const game_slides: Dictionary = {
	0: {
		0: {
			"text": "slide_0_0",
			"image": "res://sprites/slides/win.jpg"
		},
		1: {
			"text": "slide_0_1",
			"image": "res://sprites/slides/lights_out.jpg"
		},
		2: {
			"text": "slide_0_2",
			"image": "res://sprites/slides/tutorial.jpg"
		},
		3: {
			"text": "slide_0_3",
			"image": "res://sprites/slides/tutorial_lowenergy.jpg"
		},
		4: {
			"text": "slide_0_4",
			"image": "res://sprites/slides/tutorial_overcharge.jpg"
		},
		5: {
			"text": "slide_0_5",
			"image": "res://sprites/slides/tutorial_pollution.jpg"
		}
	},
	1: {
		0: {
			"text": "slide_1_0",
			"image": "res://sprites/slides/concert.jpg"
		}
	},
	2: {
		0: {
			"text": "slide_2_0",
			"image": "res://sprites/slides/pollution_slide.jpg"
		}
	}
}

@onready var load_scene = load("res://scenes/gameplay/gameplay.tscn")

var current_slide: int = 0

func load_first_slide(level: int) -> void:
	load_slide(level, 0)

func _on_button_pressed() -> void:
	load_next_slide()

func load_slide(level: int, slide: int) -> void:
	$TextureRect.texture = load(game_slides[level][slide].image)
	$Panel/RichTextLabel.text = "[center]%s" % TranslationServer.tr(game_slides[level][slide].text)

func load_next_slide() -> void:
	current_slide += 1
	var current_level: int = $"..".current_level
	if current_slide < game_slides[current_level].size():
		load_slide(current_level, current_slide)
	else:
		visible = false
		get_tree().paused = false
		$"..".start_level()
