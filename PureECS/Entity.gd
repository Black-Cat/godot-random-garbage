extends Node

export(Array, Resource) var components = []
export(Array, Resource) var systems = []

func _ready():
	for i in range(systems.size()):
		systems[i] = systems[i].new()
		systems[i].on_create(self)

func _process(delta):
	for system in systems:
		system.update(delta)
