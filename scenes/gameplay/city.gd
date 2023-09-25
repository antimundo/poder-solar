extends Sprite2D

var does_add_pollution: bool = false

func _ready():
	await get_tree().create_timer(2)
	$Timer.start()

func _on_timer_timeout():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("city_gather")
	add_money(10)
	add_energy(-1)
	if does_add_pollution:
		add_pollution(1)

func add_money(quantity: int):
	$GatherIcons/MoneyUp/AnimationPlayer.stop()
	$GatherIcons/MoneyUp/AnimationPlayer.play("gather")
	$"../Managers/MoneyManager".add_money(quantity)

func add_energy(quantity: int):
	$GatherIcons/EnergyDown/AnimationPlayer.stop()
	$GatherIcons/EnergyDown/AnimationPlayer.play("gather")
	$"../Managers/EnergyManager".add_energy(quantity)

func add_pollution(quantity: int):
	$GatherIcons/PollutionUp/AnimationPlayer.stop()
	$GatherIcons/PollutionUp/AnimationPlayer.play("gather")
	$"../Managers/PollutionManager".add_pollution(quantity)
