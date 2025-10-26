extends Control

const massbodyres = preload("res://Scenes/Bodies/mass_body.tscn")
@export var SpawnOffset = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	global_position = Vector2(0,0)
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouseposition = get_global_mouse_position()
	var mouseoffset = get_local_mouse_position()
	var current_scene = get_tree().get_current_scene()
	
	if Input.is_action_just_pressed("SpawnBody") :
		var massbody : RigidBody2D = massbodyres.instantiate()
		massbody.bodymass = $BodyMass.value
		massbody.scaling = $Scaling.value
		massbody.modulate = $ColorPickerButton.color
		massbody.get_node("Trail2D").modulate = $ColorPickerButton.color
		massbody.get_node("OrbitPath").modulate = $ColorPickerButton.color
		current_scene.add_child(massbody)
		massbody.global_position = mouseposition + SpawnOffset
		
		massbody.linear_velocity.x = $Velocity.value * cos(deg_to_rad($Angle.value))
		massbody.linear_velocity.y = $Velocity.value * sin(deg_to_rad($Angle.value))
		print(mouseposition)
		print(massbody.global_position)
	
	$TextBodyMass.text = "Body Mass : " + str($BodyMass.value)
	$TextScaling.text = "Scaling : " + str($Scaling.value)
	$TextVelocity.text = "Velocity : " + str($Velocity.value)
	$TextAngle.text = "Launch Angle : " + str($Angle.value) + "°"
