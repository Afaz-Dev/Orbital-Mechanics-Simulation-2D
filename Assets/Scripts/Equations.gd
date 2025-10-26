extends Node

var GConstant = 6.6743
var GConstantReal = 6.6743 * pow(10, -11)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func orbitalpolarchord(eccentric, majoraxis, deg) :
	var latus = 0 
	var radial = 0
	if (eccentric < 1) and (eccentric >= 0) :
		latus = majoraxis * (1 - pow(eccentric, 2))
	elif (eccentric > 1) :
		latus = -majoraxis * (1 - pow(eccentric, 2))
	
	radial = (latus / (1 + eccentric * cos(deg * (PI / 180))))
	return radial

func ToVectors(radius, deg) :
	var vec = Vector2(radius*cos(deg * (PI / 180)), radius*sin(deg * (PI / 180)))
	return vec

func velocity(gravconstant, majoraxis, deg) :
	var rad = orbitalpolarchord(gravconstant, majoraxis, deg)
	var v = pow(gravconstant, 1/2) * pow((2/rad) - (1/majoraxis), 1/2)
	return v
