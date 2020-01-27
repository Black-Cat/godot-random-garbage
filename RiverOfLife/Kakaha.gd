extends Spatial

var elapsed_time = 0.0

func _process(delta):
	elapsed_time += delta
	#global_transform.origin.y = sin(elapsed_time * 4) * 0.25
