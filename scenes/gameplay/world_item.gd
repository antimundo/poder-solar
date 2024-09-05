extends Node2D

@export var sell_price: int
@export_category("Resources gathered")
@export var money: int
@export var energy: int
@export var pollution: int

signal on_instantiated
signal on_resource_gathered(money: int, energy: int, pollution: int)
signal on_sell(money: int)

var is_hovering: bool = false
var is_instantiated: bool = false
var sell_button_tween: Tween

func _ready() -> void:
	$SellButton/Money2.text = str(sell_price)

func _process(_delta: float) -> void:
	if !is_instantiated:
		var mouse_position = get_viewport().get_mouse_position()
		position = mouse_position
		modulate = Color("ffffff")
		if !can_be_placed():
			modulate = Color("ffa092")
	if $SellButton.visible:
		if not Rect2(Vector2(), $SellButton.size).has_point($SellButton.get_local_mouse_position()):
			_on_sell_button_mouse_exited()


func _input(_event: InputEvent) -> void:
	if !is_instantiated and Input.is_action_just_released("click"):
		if can_be_placed():
			on_instantiated.emit()
			$Timer.start()
			is_instantiated = true
			self.modulate = Color("ffffff")
			if get_node_or_null("CPUParticles2D") != null:
				$CPUParticles2D.emitting = true
			if get_node_or_null("CPUParticles2D2") != null:
				$CPUParticles2D.emitting = true
			$AnimationPlayer.play("on_placed")
		else:
			queue_free()

func can_be_placed() -> bool:
	if (position.x > 775 or position.x < 25\
		or position.y > 450 or position.y < 130)\
		or (position.x < 190 and position.y > 270):
		return false
	for sibling in get_parent().get_children():
		if sibling != self and position.distance_to(sibling.position) < 20:
			return false
	return true

func _on_timer_timeout() -> void:
	$AnimationPlayer.play("on_gathered")
	on_resource_gathered.emit(money, energy, pollution)

func _on_button_pressed() -> void:
	$Timer.stop()
	$SellButton.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	$SellButtonHitbox.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	on_sell.emit(sell_price)
	$SellButton.visible = false
	$AnimationPlayer.play("on_sell")
	await $AnimationPlayer.animation_finished
	queue_free()

func _on_sell_button_hitbox_mouse_entered() -> void:
	is_hovering = true
	if !is_instantiated:
		return
	$SellButton.visible = true
	$SellButton.modulate = Color("ffffff", 0)
	if sell_button_tween != null:
		sell_button_tween.kill()
	sell_button_tween = create_tween().set_trans(Tween.TRANS_SINE)
	sell_button_tween.tween_property($SellButton, "modulate", Color("ffffff", 1), .2)

func _on_sell_button_mouse_exited() -> void:
	if !is_hovering:
		return
	is_hovering = false
	if sell_button_tween != null:
		sell_button_tween.kill()
	sell_button_tween = create_tween().set_trans(Tween.TRANS_SINE)
	sell_button_tween.tween_property($SellButton, "modulate", Color("ffffff", 0), .2)
	await sell_button_tween.finished
	$SellButton.visible = false
