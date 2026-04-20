extends RigidBody2D

@export var bodymass: float = 10000.0
@export var scaling: float = 1.0

@onready var G = Equations.GConstant

func _ready():
	mass = bodymass

	$Sprite2D.scale *= scaling
	$CollisionShape2D.scale *= scaling


func _physics_process(delta):
	var bodies = get_tree().get_nodes_in_group("bodies")

	for other in bodies:
		if other == self:
			continue

		var offset: Vector2 = other.global_position - global_position
		var distance: float = offset.length()

		if distance < 3.0:
			continue

		var direction: Vector2 = offset / distance

		var softening: float = 25.0

		# acceleration
		var acceleration: float = (G * other.mass) / (distance * distance + softening * softening)

		apply_central_force(direction * acceleration * mass)
