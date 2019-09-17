extends Spatial

export(Material) var mat

export(float) var power = 1.0 setget set_power
func set_power(value):
	power = value
	mat.set_shader_param('power', power)

var energy_direction = Vector3.AXIS_X setget set_energy_direction
func set_energy_direction(value):
	energy_direction = value
	mat.set_shader_param('direction', energy_direction)

var energy_scale = 1.0 setget set_energy_scale
func set_energy_scale(value):
	energy_scale = value
	mat.set_shader_param('scale', energy_scale)

var energy_time_wave_scale = 1.0 setget set_energy_time_wave_scale
func set_energy_time_wave_scale(value):
	energy_time_wave_scale = value
	mat.set_shader_param('wave_scale', energy_time_wave_scale)

onready var anim_player = get_node('AnimationPlayer')

func _ready():
	mat = mat.duplicate()
	for child in get_children():
		if child is MeshInstance:
			child.material_override = mat
	set_power(1.0)

func activate():
	anim_player.play('PowerUp')

func deactivate():
	anim_player.play('PowerDown')
