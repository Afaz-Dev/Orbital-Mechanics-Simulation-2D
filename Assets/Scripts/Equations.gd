extends Node

const GConstant = 6.6743
const GConstantReal = 6.6743 * pow(10, -11)

# μ = G * M
func mu(mass):
	return GConstantReal * mass


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


# velocity (vis-viva)
func velocity(mu_value, radius, majoraxis) :
	var v = pow(mu_value * ((2.0 / radius) - (1.0 / majoraxis)), 0.5)
	return v


# convert state to orbital parameters
func state_to_orbit(position: Vector2, velocity_vec: Vector2, mu_value):
	var r = position.length()
	var v = velocity_vec.length()
	
	# angular momentum 2D
	var h = position.x * velocity_vec.y - position.y * velocity_vec.x
	
	# specific energy
	var energy = (v * v) / 2 - (mu_value / r)
	
	# semi-major axis
	var majoraxis = -mu_value / (2 * energy)
	
	# eccentricity vector
	var e_vec = ((v * v - mu_value / r) * position - (position.dot(velocity_vec)) * velocity_vec) / mu_value
	var eccentric = e_vec.length()
	
	# true anomaly
	var cos_nu = e_vec.dot(position) / (eccentric * r)
	cos_nu = clamp(cos_nu, -1.0, 1.0)
	var deg = rad_to_deg(acos(cos_nu))
	
	# fix quadrant
	if position.dot(velocity_vec) < 0:
		deg = 360 - deg
	
	return {
		"majoraxis": majoraxis,
		"eccentric": eccentric,
		"true_anomaly": deg,
		"h": h
	}


# reconstruct position from orbit
func orbit_to_position(eccentric, majoraxis, deg):
	var r = orbitalpolarchord(eccentric, majoraxis, deg)
	return ToVectors(r, deg)
