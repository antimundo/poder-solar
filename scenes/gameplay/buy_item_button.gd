extends Button

@export_file("*.tscn") var gameplay_item
@export var money_cost: int = 100
@onready var world_items = $"../../World/WorldItems"

var dialogue_tween: Tween

func _ready() -> void:
	check_ui($"../../Managers/MoneyManager".money)

func _on_button_down() -> void:
	var this_item = load(gameplay_item).instantiate()
	world_items.add_child(this_item)
	this_item.on_instantiated.connect(_on_item_instantiated)
	this_item.on_resource_gathered.connect(_on_resource_gathered)
	this_item.on_sell.connect(_on_sell)

func _on_item_instantiated() -> void:
	$"../../Managers/MoneyManager".add_money(-money_cost)

func _on_money_manager_money_change(new_quantity) -> void:
	check_ui(new_quantity)

func _on_resource_gathered(money: int, energy: int, pollution: int) -> void:
	$"../../Managers/MoneyManager".add_money(money)
	$"../../Managers/EnergyManager".add_energy(energy)
	$"../../Managers/PollutionManager".add_pollution(pollution)

func _on_sell(money: int) -> void:
	$"../Sell".play()
	$"../../Managers/MoneyManager".add_money(money)

func check_ui(available_money: int) -> void:
	$Panel/Label.text = str(money_cost)
	disabled = available_money < money_cost
	if disabled:
		$Panel/Label.modulate = Color("989898")
	else:
		$Panel/Label.modulate = Color("c7fc76")

func _on_mouse_entered() -> void:
	if dialogue_tween != null:
		dialogue_tween.kill()
	dialogue_tween = create_tween().set_trans(Tween.TRANS_SINE)
	dialogue_tween.tween_property($ComicDialogue, "modulate", Color("ffffff", 1), .2)

func _on_mouse_exited() -> void:
	if dialogue_tween != null:
		dialogue_tween.kill()
	dialogue_tween = create_tween().set_trans(Tween.TRANS_SINE)
	dialogue_tween.tween_property($ComicDialogue, "modulate", Color("ffffff", 0), .2)
