extends Spatial

var death_time = 2.0

func _ready():
	$Particles.emitting = true

func _process(delta):
	death_time -= delta
	if death_time <= 0.0:
		queue_free()

