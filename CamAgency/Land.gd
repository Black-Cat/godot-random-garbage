extends MeshInstance

export(PackedScene) var floor_scene

var floors = []

func _ready():
	for x in range(-25, 25):
		var row = []
		for z in range(-25, 25):
			row.append(null)
		floors.append(row)

func recalc_walls(min_cell, max_cell):
	min_cell.x = max(-25, min_cell.x - 1)
	min_cell.y = max(-25, min_cell.y - 1)
	max_cell.x = min(25, max_cell.x + 1)
	max_cell.y = min(25, max_cell.y + 1)

	for x in range(min_cell.x, max_cell.x + 1):
		for z in range(min_cell.y, max_cell.y + 1):
			if floors[x][z] != null:
				var neighbours = [
					floors[x][z-1] if z-1 >= -25 else null,
					floors[x+1][z] if x+1 <= 25 else null,
					floors[x][z+1] if z+1 <= 25 else null,
					floors[x-1][z] if x-1 >= -25 else null,
				]
				floors[x][z].update_walls(neighbours)

func add_room(start_cell, end_cell):
	var min_cell = Vector2(min(start_cell.x, end_cell.x), min(start_cell.y, end_cell.y))
	var max_cell = Vector2(max(start_cell.x, end_cell.x), max(start_cell.y, end_cell.y))

	min_cell.x = clamp(min_cell.x, -25, 24)
	min_cell.y = clamp(min_cell.y, -25, 24)
	max_cell.x = clamp(max_cell.x, -25, 24)
	max_cell.y = clamp(max_cell.y, -25, 24)

	for x in range(min_cell.x, max_cell.x + 1):
		for z in range(min_cell.y, max_cell.y + 1):
			if floors[x][z] == null:
				var floor_node = floor_scene.instance()
				get_parent().add_child(floor_node)
				floor_node.global_transform.origin = Vector3(x + .5, 0.0, z + .5)
				floors[x][z] = floor_node

	recalc_walls(min_cell, max_cell)


