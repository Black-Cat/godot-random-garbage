extends Spatial

export(float) var speed = 1.0
export(PackedScene) var death_body_scene

func _process(delta):
	translate(Vector3.UP * speed * delta)

func _ready():
	$Area.connect('body_entered', self, 'die')

func die(body):
	var death_body = death_body_scene.instance()
	get_parent().add_child(death_body)
	death_body.global_transform = global_transform
	queue_free()
