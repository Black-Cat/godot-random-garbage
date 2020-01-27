extends RigidBody

signal out_of_area

var variant setget set_variant
func set_variant(value):
	variant = value

func _ready():
	for i in range(3):
		get_child(i+1).visible = variant == i

	if variant == 0:
		mass = 10000
	else:
		mass = 100

	if variant == 2:
		add_central_force(Vector3(0.0, 0.0, -100.0 * mass))
	else:
		add_central_force(Vector3(0.0, 0.0, 1000.0 * mass))


func _physics_process(delta):
	if global_transform.origin.z > 40.0 or global_transform.origin.z < -40.0:
		emit_signal('out_of_area')
