extends RigidBody2D

@export var bodymass = 10000.0
@export var scaling = 1.0

# Use a SMALL game-scaled G, not real-world
@onready var G = Equations.GConstant

func _ready():
	# ❌ Remove huge scaling (breaks physics engine)
	self.mass = bodymass

	# Scale visuals only
	$Sprite2D.scale *= scaling
	$CollisionShape2D.scale *= scaling


func _physics_process(delta):
	for other in get_tree().get_nodes_in_group("bodies"):
		if other == self:
			continue
		
		# Vector from THIS body to OTHER body
		var offset = other.position - self.position
		var distance = offset.length()
		
		# Prevent extreme forces / division by zero
		if distance < 5:
			continue
		
		var direction = offset.normalized()
		
		# Softening factor for stability
		var softening = 25.0
		
		# ✅ Correct acceleration formula: a = G * M / r²
		var acceleration = (G * other.mass) / ((distance * distance) + softening)
		
		# ✅ Apply force to SELF (not the other body)
		self.linear_velocity += direction * acceleration * delta
