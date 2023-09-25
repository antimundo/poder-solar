extends Control

const game_slides = {
	0: {
		0: {
			"text": "[center]¡Han instalado [b]placas solares[/b] en el pueblo!",
			"image": "res://sprites/slides/win.jpg"
		},
		1: {
			"text": "[center]Pero cuando [b]cae la noche[/b] nos quedamos sin electricidad :(",
			"image": "res://sprites/slides/lights_out.jpg"
		},
		2: {
			"text": "[center][b]Arrastra[/b] objetos a la pantalla para comprarlos",
			"image": "res://sprites/slides/tutorial.jpg"
		},
		3: {
			"text": "[center]No te quedes sin [b]electricidad[/b] o habrá un apagón",
			"image": "res://sprites/slides/tutorial_lowenergy.jpg"
		},
		4: {
			"text": "[center]Pero no te pases, demasiada electricidad producirá una [b]sobrecarga[/b]",
			"image": "res://sprites/slides/tutorial_overcharge.jpg"
		},
		5: {
			"text": "[center]Por último, no dejes que suba la [b]contaminación[/b] o habrá un desastre ecológico",
			"image": "res://sprites/slides/tutorial_pollution.jpg"
		}
	},
	1: {
		0: {
			"text": "[center]Hoy dan un concierto ¡Esto [b]aumentará[/b] el consumo eléctrico!",
			"image": "res://sprites/slides/concert.jpg"
		}
	},
	2: {
		0: {
			"text": "[center]Alguien se ha tirado un pedo y ahora el pueblo genera mucha [b]contaminación[/b]",
			"image": "res://sprites/slides/pollution_slide.jpg"
		}
	}
}

@onready var load_scene = load("res://scenes/gameplay/gameplay.tscn")

var current_slide: int = 0

func load_first_slide(level: int):
	load_slide(level, 0)

func _on_button_pressed():
	load_next_slide()

func load_slide(level: int, slide: int):
	$TextureRect.texture = load(game_slides[level][slide].image)
	$Panel/RichTextLabel.text = game_slides[level][slide].text

func load_next_slide():
	current_slide += 1
	var current_level: int = $"..".current_level
	if current_slide < game_slides[current_level].size():
		load_slide(current_level, current_slide)
	else:
		visible = false
		get_tree().paused = false
		$"..".start_level()
