extends Spatial

export(PackedScene) var lemon_scene

var lemons_pool = []

var lemon_time = 2.0
var cur_lemon_time = lemon_time

func _ready():
	randomize()

	lemons_pool.resize(50)
	for i in range(50):
		lemons_pool[i] = lemon_scene.instance()
		lemons_pool[i].connect('out_of_area', self, 'on_out_of_area_lemon', [lemons_pool[i]])

func _process(delta):
	cur_lemon_time -= delta
	if cur_lemon_time <= 0.0:
		cur_lemon_time = lemon_time
		spawn_lemon()

func on_out_of_area_lemon(lemon):
	remove_child(lemon)
	lemons_pool.push_back(lemon)

func spawn_lemon():
	var variant = randi() % 3
	var start_z = 30 if variant == 2 else -30
	var spawn_pos = Vector3(randf() * 26.0 - 13.0, 0.0, start_z)

	var lemon = lemons_pool.pop_front()
	lemon.set_variant(variant)
	add_child(lemon)
	lemon.global_transform.origin = spawn_pos
