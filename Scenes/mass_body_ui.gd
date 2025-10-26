extends Control

const massbodyres = preload("res://Scenes/Bodies/mass_body.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouseposition = get_global_mouse_position()
	var mouseoffset = get_local_mouse_position()
	var current_scene = get_tree().get_current_scene()
	
	if Input.is_action_just_pressed("SpawnBody") :
		var massbody = massbodyres.instance()
		massbody.position = mouseposition
		self.add_child(current_scene)
