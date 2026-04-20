extends RigidBody2D

@export var reference_body: RigidBody2D

var mu_value = 0
var orbit_data = {}
var has_reference = false


func _ready():
	if reference_body != null:
		has_reference = true
		mu_value = Equations.mu(reference_body.mass)
	else:
		has_reference = false
		mu_value = 0


func get_local_state():
	if has_reference:
		var r = global_position - reference_body.global_position
		var v = linear_velocity - reference_body.linear_velocity
		
		return {
			"r": r,
			"v": v
		}
	else:
		return {
			"r": global_position,
			"v": linear_velocity
		}


func _physics_process(delta):

	if reference_body == null:
		return

	# safety check in case it gets freed
	if not is_instance_valid(reference_body):
		return

	var state = get_local_state()
	var r = state.r
	var v = state.v

	orbit_data = Equations.state_to_orbit(r, v, mu_value)
	print(orbit_data)
