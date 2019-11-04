extends ColorRect

onready var damage = get_node('HBoxContainer/VBoxContainer/GridContainer/DamageSpinBox')
onready var armor_penetration = get_node('HBoxContainer/VBoxContainer/GridContainer/DamageSpinBox2')

onready var hp = get_node('HBoxContainer/VBoxContainer2/GridContainer2/DamageSpinBox')
onready var armor = get_node('HBoxContainer/VBoxContainer2/GridContainer2/DamageSpinBox2')

onready var attack_button = get_node('HBoxContainer/VBoxContainer3/Button')
onready var last_damage = get_node('HBoxContainer/VBoxContainer3/LastDamage')

func _ready():
	last_damage.text = ''
	attack_button.connect('button_up', self, 'attack')

func attack():
	var effective_armor = armor.value * (1.0 - (armor_penetration.value / 100.0))

	var damage_multiplier = 1.0
	if effective_armor <= 0:
		damage_multiplier = 2.0 - 100.0 / (100.0 - effective_armor)
	else:
		damage_multiplier = 100.0 / (100.0 + effective_armor)

	var effective_damage = damage.value * damage_multiplier
	last_damage.text = '-' + str(effective_damage)
	hp.value -= effective_damage
