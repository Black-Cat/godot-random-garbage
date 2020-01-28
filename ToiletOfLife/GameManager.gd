extends Spatial

onready var camera = $Camera
export(PackedScene) var object_scene

func shoot_object(pos):
	var ob = object_scene.instance()
	add_child(ob)
	ob.global_transform.origin = camera.global_transform.origin + Vector3.UP * 10.0
	ob.apply_central_impulse((pos - ob.global_transform.origin).normalized() * 10.0)

func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	var world_plane = Plane(Vector3.UP, 1.0)
	var mouse_on_plane = world_plane.intersects_ray(
		camera.project_ray_origin(mouse_pos),
		camera.project_ray_normal(mouse_pos)
	)

	if Input.is_mouse_button_pressed(BUTTON_LEFT):
			shoot_object(mouse_on_plane)
