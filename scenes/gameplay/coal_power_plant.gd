extends Node2D

signal on_instantiated
signal on_resource_gathered(money: int, energy: int, pollution: int)
signal on_sell(money: int)

var is_instantiated: bool = false
var sell_button_tween: Tween

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
			$Timer.start()
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

func _on_timer_timeout():
	$AnimationPlayer.play("on_gathered")
	on_resource_gathered.emit(0, 1, 1)

func _on_button_pressed():
	$Timer.stop()
	$SellButton.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	$SellButtonHitbox.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	on_sell.emit(60)
	$SellButton.visible = false
	$AnimationPlayer.play("on_sell")
	await $AnimationPlayer.animation_finished
	queue_free()

func _on_sell_button_hitbox_mouse_entered():
	if !is_instantiated:
		return
	$SellButton.visible = true
	$SellButton.modulate = Color("ffffff", 0)
	if sell_button_tween != null:
		sell_button_tween.kill()
	sell_button_tween = create_tween().set_trans(Tween.TRANS_SINE)
	sell_button_tween.tween_property($SellButton, "modulate", Color("ffffff", 1), .2)

func _on_sell_button_mouse_exited():
	if sell_button_tween != null:
		sell_button_tween.kill()
	sell_button_tween = create_tween().set_trans(Tween.TRANS_SINE)
	sell_button_tween.tween_property($SellButton, "modulate", Color("ffffff", 0), .2)
	await sell_button_tween.finished
	$SellButton.visible = false
