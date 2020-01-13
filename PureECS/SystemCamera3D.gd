extends System

var camera
var transform_component
var time = 0.0

func on_create(owner):
	camera = Camera.new()
	owner.add_child(camera)
	for component in owner.components:
		if component is Transform3D:
			transform_component = component
			break

func update(delta):
	if transform_component == null:
		return

	time += delta
	camera.transform = transform_component.transform.translated(Vector3(0.0, sin(time), 0.0))
