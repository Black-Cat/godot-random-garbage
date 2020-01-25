extends Spatial

export(PackedScene) var undead_scene
export(PackedScene) var graveyard_keeper_scene
export(NodePath) onready var min_spawn_point = get_node(min_spawn_point)
export(NodePath) onready var max_spawn_point = get_node(max_spawn_point)
export(NodePath) onready var graveyard_keeper_spawn_point = get_node(graveyard_keeper_spawn_point)
export(float) var undead_res_rate = 5.0

onready var time_to_res_undead = undead_res_rate

func _ready():
	randomize()

	var graveyard_keeper = graveyard_keeper_scene.instance()
	add_child(graveyard_keeper)
	graveyard_keeper.global_transform.origin = graveyard_keeper_spawn_point.global_transform.origin

func res_undead():
	var min_pos = min_spawn_point.global_transform.origin
	var max_pos = max_spawn_point.global_transform.origin
	var spawn_pos = Vector3(
		min_pos.x + randf() * (max_pos.x - min_pos.x),
		min_pos.y + randf() * (max_pos.y - min_pos.y),
		0.0
	)

	var undead = undead_scene.instance()
	add_child(undead)
	undead.global_transform.origin = spawn_pos

func _process(delta):
	time_to_res_undead -= delta
	if time_to_res_undead <= 0.0:
		res_undead()
		time_to_res_undead = undead_res_rate
