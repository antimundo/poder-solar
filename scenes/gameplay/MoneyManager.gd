extends Node

signal on_money_change(new_quantity)

var money: int = 200
var money_to_show: int
@onready var money_label = $"../../BottomPanel/MoneyLabel"

func _ready():
	money_to_show = money

func _process(delta):
	money_label.text = str(money_to_show)

func add_money(quantity: int):
	money += quantity
	on_money_change.emit(money)
	if quantity < 0:
		var money_tween: Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		money_tween.tween_property(self, "money_to_show", money, .2)
		var color_tween: Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		color_tween.tween_property(money_label, "modulate", Color("ffaaaa"), .05)
		color_tween.tween_property(money_label, "modulate", Color("ffffff"), .3)
