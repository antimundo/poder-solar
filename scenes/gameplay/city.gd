extends Sprite2D

var does_add_pollution: bool = false

func _ready() -> void:
	$Timer.start()

func _on_timer_timeout() -> void:
	$AnimationPlayer.stop()
	$AnimationPlayer.play("city_gather")
	add_money(10)
	add_energy(-1)
	if does_add_pollution:
		add_pollution(1)

func add_money(quantity: int) -> void:
	$GatherIcons/MoneyUp/AnimationPlayer.stop()
	$GatherIcons/MoneyUp/AnimationPlayer.play("gather")
	$"../Managers/MoneyManager".add_money(quantity)

func add_energy(quantity: int) -> void:
	$GatherIcons/EnergyDown/AnimationPlayer.stop()
	$GatherIcons/EnergyDown/AnimationPlayer.play("gather")
	$"../Managers/EnergyManager".add_energy(quantity)

func add_pollution(quantity: int) -> void:
	$GatherIcons/PollutionUp/AnimationPlayer.stop()
	$GatherIcons/PollutionUp/AnimationPlayer.play("gather")
	$"../Managers/PollutionManager".add_pollution(quantity)
