extends Spatial

export(PackedScene) var wall_scene

var walls = [null, null, null, null]

func add_wall(dir):
	if walls[dir] != null:
		return

	var wall_node = wall_scene.instance()
	add_child(wall_node)

	if dir % 2 == 1:
		wall_node.rotate(Vector3.UP, -PI / 2.0)

	if dir == 0:
		wall_node.translation = Vector3(0.0, 0.0, -0.5)
	elif dir == 1:
		wall_node.translation = Vector3(0.5, 0.0, 0.0)
	elif dir == 2:
		wall_node.translation = Vector3(0.0, 0.0, 0.5)
	elif dir == 3:
		wall_node.translation = Vector3(-0.5, 0.0, 0.0)

	walls[dir] = wall_node

func remove_wall(dir):
	if walls[dir] == null:
		return

	remove_child(walls[dir])
	walls[dir].queue_free()
	walls[dir] = null

func update_walls(neighbours):
	for i in range(0, 4):
		if neighbours[i] == null:
			add_wall(i)
		else:
			remove_wall(i)
