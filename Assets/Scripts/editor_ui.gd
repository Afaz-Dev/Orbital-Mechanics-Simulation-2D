extends Control

const massbodyres = preload("res://Scenes/Bodies/mass_body.tscn")

@export var SpawnOffset := Vector2.ZERO

var current_scene: Node
var camera: Camera2D

func _ready():
	global_position = Vector2.ZERO
	current_scene = get_tree().current_scene
	camera = get_viewport().get_camera_2d()

	# Optional for debugging / control feel
	# Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _process(_delta):
	_handle_spawn()
	_handle_clear()
	_update_ui()


# ----------------------------
# SPAWN SYSTEM
# ----------------------------
func _handle_spawn():
	if Input.is_action_just_pressed("SpawnBody"):
		var mouse_pos := camera.get_global_mouse_position()

		var body := massbodyres.instantiate() as RigidBody2D

		# --- physics params ---
		body.bodymass = $BodyMass.value
		body.scaling = $Scaling.value

		# --- visuals ---
		var col: Color = $ColorPickerButton.color
		body.modulate = col
		body.get_node("Trail2D").modulate = col
		body.get_node("OrbitPath").modulate = col

		# --- physics initial velocity ---
		var angle_rad := deg_to_rad($Angle.value)
		var speed: float = $Velocity.value

		body.linear_velocity = Vector2(
			cos(angle_rad) * speed,
			sin(angle_rad) * speed
		)

		# --- grouping (IMPORTANT for cleanup + future sim systems) ---
		body.add_to_group("bodies")

		# --- add to world ---
		current_scene.add_child(body)
		body.global_position = mouse_pos + SpawnOffset

		# Debug
		#print("Spawned at: ", body.global_position)


# ----------------------------
# CLEAR SYSTEM (OPTIMIZED)
# ----------------------------
func _handle_clear():
	if Input.is_action_just_pressed("clear_bodies"):
		var bodies = get_tree().get_nodes_in_group("bodies")

		for b in bodies:
			if is_instance_valid(b):
				b.queue_free()


# ----------------------------
# UI UPDATE (cached node access)
# ----------------------------
func _update_ui():
	pass
	#$TextBodyMass.text = "Body Mass : " + str($BodyMass.value)
	#$TextScaling.text = "Scaling : " + str($Scaling.value)
	#$TextVelocity.text = "Velocity : " + str($Velocity.value)
	#$TextAngle.text = "Launch Angle : " + str($Angle.value) + "°"
