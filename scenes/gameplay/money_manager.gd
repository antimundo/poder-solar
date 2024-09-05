extends Node

signal money_change(new_quantity)

var money: int = 250
var money_to_show: int
@onready var money_label = $"../../BottomPanel/MoneyLabel"

func _ready() -> void:
	money_to_show = money

func _process(_delta: float) -> void:
	money_label.text = str(money_to_show)

func add_money(quantity: int) -> void:
	money += quantity
	money_change.emit(money)
	var money_tween: Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	money_tween.tween_property(self, "money_to_show", money, .2)
	if quantity < 0:
		var color_tween: Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		color_tween.tween_property(money_label, "modulate", Color("ffaaaa"), .05)
		color_tween.tween_property(money_label, "modulate", Color("ffffff"), .3)
		$PlaceItem.play()
