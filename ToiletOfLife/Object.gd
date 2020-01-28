extends RigidBody

var vortexing = false

var x
var z
var elapsed_time = 0.0

func _physics_process(delta):
	if not vortexing:
		return

	elapsed_time += delta
	var pos = Vector3(cos(delta) * x, global_transform.origin.y, sin(delta) * z)
	#global_transform.origin = pos
