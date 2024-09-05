extends Node

@onready var end_scene = load("res://scenes/end_screen/end_scren.tscn")
@onready var slides = $Slides

var current_level: int = 0

func _ready() -> void:
	load_slides()

func load_end_screen(end_state: end_screen.end_states) -> void:
	var this_scene = end_scene.instantiate()
	get_tree().root.add_child(this_scene)
	this_scene.set_state(end_state)
	queue_free()

func load_level() -> void:
	match current_level:
		0:
			$AudioStreamPlayer.set_volume_db(-10)
			$AudioStreamPlayer.stream = load("res://sounds/Frédéric Lardon - Cellphone - 01 MEGATEUF !!.ogg")
			$AudioStreamPlayer.play()
		1:
			$AudioStreamPlayer.set_volume_db(-10)
			$AudioStreamPlayer.stream = load("res://sounds/concert.ogg")
			$AudioStreamPlayer.play()
			$ConcertLights.visible = true
			$City/Timer.set_wait_time(.5)
		2:
			$AudioStreamPlayer.stream = load("res://sounds/Frédéric Lardon - Cellphone - 03 GIGA TEUF HARDCORE.ogg")
			$AudioStreamPlayer.play()
			$ConcertLights.visible = false
			$Pollution.visible = true
			$City/Timer.set_wait_time(.4)
			$City.does_add_pollution = true

func start_level() -> void:
	var moon_tween: Tween = create_tween()
	$Moon.position.x = 75
	moon_tween.tween_property($Moon, "position:x", 750, 60)
	load_level()
	current_level += 1
	await moon_tween.finished
	if current_level >= 3:
		load_end_screen(end_screen.end_states.WIN)
	else:
		load_slides()

func load_slides() -> void:
	get_tree().paused = true
	slides.visible = true
	slides.load_first_slide(current_level)
