extends System

var cube
var transform_component

func on_create(owner):
	cube = MeshInstance.new()
	cube.mesh = CubeMesh.new()
	owner.add_child(cube)
	for component in owner.components:
		if component is Transform3D:
			transform_component = component
			break

func update(delta):
	if transform_component == null:
		return

	cube.transform = transform_component.transform
