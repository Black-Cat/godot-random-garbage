extends Spatial

export(float) var attack_cooldown = 0.5
export(float) var restore_cooldown = 0.1

onready var current_attack_cooldown = -1.0
onready var current_restore_cooldown = -1.0
var attacking = false
var restoring = false
onready var initial_transform = $MainBody.transform

func _physics_process(delta):
	if attacking:
		if current_attack_cooldown <= 0:
			attacking = false
			current_restore_cooldown = restore_cooldown
			restoring = true
	
		current_attack_cooldown -= delta
		var cooldown_coef = (attack_cooldown - current_attack_cooldown) / attack_cooldown
		$MainBody.transform = initial_transform.rotated(Vector3.RIGHT, ease(cooldown_coef, 4.0) * PI / 2)
	elif restoring:
		if current_restore_cooldown <= 0:
			restoring = false
			$MainBody/Top/RigidBody/CollisionShape.disabled = true

		current_restore_cooldown -= delta
		var cooldown_coef = (restore_cooldown - current_restore_cooldown) / restore_cooldown
		$MainBody.transform = initial_transform.rotated(Vector3.RIGHT, (PI/2) - ease(cooldown_coef, 1.0) * PI / 2)

func attack():
	if not attacking and not restoring:
		$MainBody/Top/RigidBody/CollisionShape.disabled = false
		attacking = true
		current_attack_cooldown = attack_cooldown
