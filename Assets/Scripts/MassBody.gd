extends RigidBody2D

@export var bodymass = 10000.00
@export var scaling = 1.00
@onready var GM = null

# Called when the node enters the scene tree for the first time.
func _ready():
	self.mass = bodymass * pow(10, 12)
	GM = (Equations.GConstant * bodymass) #* scaling
	$Sprite2D.scale = Vector2($Sprite2D.scale.x * scaling, $Sprite2D.scale.y * scaling)
	$CollisionShape2D.scale = Vector2($CollisionShape2D.scale.x * scaling, $CollisionShape2D.scale.y * scaling)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta) :
	for ToAttract in get_tree().get_nodes_in_group("bodies"):
		if not ToAttract == self :
			var distance = sqrt(pow(ToAttract.position.x - self.position.x, 2) + pow(ToAttract.position.y - self.position.y, 2))
			var g = (GM) / (pow(distance, 2))
			
			var dir = ToAttract.get_angle_to(self.position)
			ToAttract.linear_velocity.x += g * cos(dir) * delta*16
			ToAttract.linear_velocity.y += g * sin(dir) * delta*16
