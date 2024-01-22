class_name SUVAT

var s : float # distance
var u : float # initial velocity
var v : float # velocity at time t
var a : float # acceleration
var t : float # time

func _init(_s,_u,_v,_a,_t):
	if _s != null: s = _s
	if _u != null: u = _u
	if _v != null: v = _v
	if _a != null: a = _a
	if _t != null: t = _t
	solve(_s != null, _u != null, _v != null, _a != null, _t != null)
	
func solve(_s, _u, _v, _a, _t):
	if not _s:
		_solve_for_s(_u, _v, _a, _t)
	if not _u:
		_solve_for_u(_s, _v, _a, _t)
	if not _v:
		_solve_for_v(_s, _u, _a, _t)	
	if not _a:
		_solve_for_a(_s, _u, _v, _t)
	if not _t:
		_solve_for_t(_s, _u, _v, _a)
	
func _solve_for_s(_u, _v, _a, _t):
	if _u and _v and _t:
		s = ((u + v) / 2) * t
	elif _v and _a and _t:
		s = (v * t) - ((a  * (t * t)) /2)
	elif _u and _t and _a:
		s = (u * t) + ((a * (t * t)) / 2)
	elif _v and _u and _a:
		s = ((v * v) - (u * u)) / (2 * a)

func _solve_for_u(_s, _v, _a, _t):
	if _v and _a and _t:
		u = v - (a * t)
	elif _v and _a and _s:
		u = sqrt((v * v) - (2* (a * s)))
	elif _s and _t and _a:
		u = (s - ((a * (t * t)) / 2)) / t
	elif _s and _v and _t:
		u = ((2 * s) / t) - v

func _solve_for_v(_s, _u, _a, _t):
	if _s and _u and _a:
		v = sqrt( pow(u, 2) + (2 * (a * s)) )
	elif _u and _a and _t:
		v = u + (a * t)
	elif _s and _a and _t:
		v = (s + ((a * pow(t, 2)) / 2)) / t
	elif _s and _u and _t:
		v = ((2 * s) / t) - u

func _solve_for_a(_s, _u, _v, _t):
	if _s and _u and _v:
		a = (pow(v, 2) - pow(u, 2)) / (2 * s)
	elif _u and _v and _t:
		a = (v - u) / t
	elif _s and _v and _t:
		a = ((v * t) - s) / (pow(t, 2) / 2)
	elif _s and _u and _t:
		a = (s - (u * t)) / (pow(t, 2) / 2)
	
	a = abs(a)
		
func _solve_for_t(_s, _u, _v, _a):
	if _s and _u and _v:
		t = (2 * s) / (u + v)
	elif _s and _v and _a:
		t = (-v + sqrt(pow(v, 2) - (2 * ( a * s )))) / -a
	elif _s and _u and _a:
		t = (-u + sqrt(pow(u, 2) + (2 * (a * s)))) / a
	elif _u and _v and _a:
		t = (v - u) / a

func _to_string():
	return "S %f U %f V %f A %f T %f" % [s, u, v, a, t]
