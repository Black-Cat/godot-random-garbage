extends KinematicBody

export(float) var speed = 1.0
export(float) var turn_speed = 1.0

var body_right_transform

# Turn coef [-1.0, 1.0], where -1.0 looking left and 1.0 looking right
var turn_coef = 1.0 setget set_turn_coef
func set_turn_coef(value):
	turn_coef = clamp(value, -1.0, 1.0)
	$Body.transform = body_right_transform.rotated(Vector3.UP, -PI + ((turn_coef + 1.0) / 2.0) * PI)

func _ready():
	body_right_transform = Transform($Body.transform)

func _physics_process(delta):
	var dir = Vector3()

	if Input.is_action_pressed("ui_left"):
		dir.x -= 1
	if Input.is_action_pressed("ui_right"):
		dir.x += 1
	if Input.is_action_pressed("ui_accept"):
		$Body/MightySpade.attack()

	self.turn_coef += dir.x * delta * turn_speed

	move_and_slide(dir * speed)
