extends Node2D

signal on_instantiated
var is_instantiated: bool = false

func _process(_delta):
	if !is_instantiated:
		var mouse_position = get_viewport().get_mouse_position()
		position = mouse_position
		modulate = Color("ffffff")
		if !can_be_placed():
			modulate = Color("ffa092")

func _input(_event):
	if !is_instantiated and Input.is_action_just_released("click"):
		if can_be_placed():
			on_instantiated.emit()
			is_instantiated = true
			self.modulate = Color("ffffff")
			$CPUParticles2D.emitting = true
			$AnimationPlayer.play("on_placed")
		else:
			queue_free()

func can_be_placed():
	if position.x > 775 or position.x < 25\
		or position.y > 450 or position.y < 130:
		return false
	for sibling in get_parent().get_children():
		if sibling != self and position.distance_to(sibling.position) < 20:
			return false
	return true
