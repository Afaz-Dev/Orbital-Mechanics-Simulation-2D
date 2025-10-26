extends Node2D

@export var zoomspeed = 0.1
@export var movespeed = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#zooming
	if Input.is_action_just_pressed("zoomIn") :
		$Camera2D.zoom.x += zoomspeed
		$Camera2D.zoom.y += zoomspeed
	if Input.is_action_just_pressed("zoomOut") :
		$Camera2D.zoom.x -= zoomspeed
		$Camera2D.zoom.y -= zoomspeed
	
	#moving
	if Input.is_action_pressed("mousemoveup") :
		position.y += -movespeed
	if Input.is_action_pressed("mousemovedown") :
		position.y += movespeed
	if Input.is_action_pressed("mousemoveright") :
		position.x += movespeed
	if Input.is_action_pressed("mousemoveleft") :
		position.x += -movespeed
	
	Globals.CamPos = self.global_position
