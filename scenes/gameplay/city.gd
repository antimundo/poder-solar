extends Sprite2D

func _ready():
	await get_tree().create_timer(2)
	$Timer.start()

func _on_timer_timeout():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("city_gather")
	add_money(10)
	add_energy(-1)

func add_money(quantity: int):
	$GatherIcons/MoneyUp/AnimationPlayer.stop()
	$GatherIcons/MoneyUp/AnimationPlayer.play("gather")
	$"../Managers/MoneyManager".add_money(quantity)

func add_energy(quantity: int):
	$GatherIcons/EnergyDown/AnimationPlayer.stop()
	$GatherIcons/EnergyDown/AnimationPlayer.play("gather")
	$"../Managers/EnergyManager".add_energy(quantity)
