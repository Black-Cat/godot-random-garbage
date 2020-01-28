extends Area

func _ready():
	connect('body_entered', self, 'destroy_body')

func destroy_body(body):
	if body is RigidBody:
		body.queue_free()
