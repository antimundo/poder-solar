extends Button

@export_file("*.tscn") var gameplay_item
@export var money_cost: int = 100
@onready var world_items = $"../../World/WorldItems"

func _ready():
	check_ui($"../../Managers/MoneyManager".money)

func _on_button_down():
	var this_item = load(gameplay_item).instantiate()
	world_items.add_child(this_item)
	this_item.on_instantiated.connect(_on_item_instantiated)
	this_item.on_resource_gathered.connect(_on_resource_gathered)

func _on_item_instantiated():
	$"../../Managers/MoneyManager".add_money(-money_cost)

func _on_money_manager_on_money_change(new_quantity):
	check_ui(new_quantity)

func _on_resource_gathered(money: int, energy: int, _pollution: int):
	$"../../Managers/MoneyManager".add_money(money)
	$"../../Managers/EnergyManager".add_energy(energy)
	# TODO: Add pollution

func check_ui(available_money: int):
	$Panel/Label.text = str(money_cost)
	disabled = available_money < money_cost
	if disabled:
		$Panel/Label.modulate = Color("989898")
	else:
		$Panel/Label.modulate = Color("c7fc76")
