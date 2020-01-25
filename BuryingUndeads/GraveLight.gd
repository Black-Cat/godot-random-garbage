extends OmniLight

export(NodePath) onready var light_model = get_node(light_model)

onready var start_z = self.translation.z

func _physics_process(delta):
	global_transform.origin = light_model.global_transform.origin
	global_transform.origin.z = start_z
