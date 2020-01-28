extends Area


func _ready():
	connect('body_entered', self, 'vertex_body')

func vertex_body(body):
	if body is RigidBody:
		body.linear_velocity = Vector3.ZERO
		#body.gravity_scale = 0.0
		#body.mode = RigidBody.MODE_KINEMATIC
		body.vortexing = true
		body.x = body.global_transform.origin.x
		body.z = body.global_transform.origin.z
