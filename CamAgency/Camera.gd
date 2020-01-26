extends Camera

signal zone_selected(start_cell, end_cell)

onready var focal_point = get_node('FocalPoint')
export(NodePath) onready var min_world_point = get_node(min_world_point)
export(NodePath) onready var max_world_point = get_node(max_world_point)
export(NodePath) onready var land = get_node(land)

export(float) var camera_speed = 10.0

var land_material
var start_cell = Vector2(0.0, 0.0)
var mouse_dragging = false
var mouse_on_plane

func _ready():
	look_at(focal_point.global_transform.origin, Vector3.UP)

	land_material = land.mesh.surface_get_material(0)

func update_mouse_pos():
	var world_plane = Plane(Vector3.UP, 0.0)
	var mouse_pos = get_viewport().get_mouse_position()
	mouse_on_plane = world_plane.intersects_ray(
		project_ray_origin(mouse_pos),
		project_ray_normal(mouse_pos)
	)

	land_material.set_shader_param('mouse_pos', mouse_on_plane)

func check_user_mouse_input():
	if not mouse_dragging:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			mouse_dragging = true
			start_cell = Vector2(floor(mouse_on_plane.x), floor(mouse_on_plane.z))
	else:
		if not Input.is_mouse_button_pressed(BUTTON_LEFT):
			mouse_dragging = false
			var end_cell = Vector2(floor(mouse_on_plane.x), floor(mouse_on_plane.z))
			emit_signal('zone_selected', start_cell, end_cell)

func _process(delta):
	var dir = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		dir.x -= 1
	if Input.is_action_pressed("ui_right"):
		dir.x += 1
	if Input.is_action_pressed("ui_up"):
		dir.y -= 1
	if Input.is_action_pressed("ui_down"):
		dir.y += 1

	var global_forward = global_transform.basis.z
	global_forward.y = 0
	global_forward = global_forward.normalized()

	var global_right = global_transform.basis.x
	global_right.y = 0
	global_right = global_right.normalized()

	global_translate(global_right * dir.x * camera_speed * delta)
	global_translate(global_forward * dir.y * camera_speed * delta)

	var min_pos = min_world_point.global_transform.origin
	var max_pos = max_world_point.global_transform.origin
	var foc_pos = focal_point.global_transform.origin

	var return_offset = Vector3.ZERO

	if foc_pos.x < min_pos.x:
		return_offset.x = min_pos.x - foc_pos.x
	elif foc_pos.x > max_pos.x:
		return_offset.x = max_pos.x - foc_pos.x

	if foc_pos.z < min_pos.z:
		return_offset.z = min_pos.z - foc_pos.z
	elif foc_pos.z > max_pos.z:
		return_offset.z = max_pos.z - foc_pos.z

	global_translate(return_offset)

	update_mouse_pos()
	check_user_mouse_input()
