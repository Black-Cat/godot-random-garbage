extends MeshInstance

export(PackedScene) var tree_scene
export(bool) var left = true
export(float) var speed = 10.0

var trees = []

func _ready():
	var tree_count = randi() % 10
	for i in range(tree_count):
		var spawn_point = Vector3((randf() * 2 + 11) * (int(left) * 2.0 - 1.0), randf() * 2 - 1, randf() * 60 - 30)
		var tree = tree_scene.instance()
		add_child(tree)
		tree.translation = spawn_point
		trees.push_back(tree)

func _process(delta):
	for tree in trees:
		tree.translate(Vector3(0.0, 0.0, 1.0) * speed * delta)
		if tree.global_transform.origin.z > 30:
			tree.global_transform.origin.z = -30 + tree.global_transform.origin.z - 30
