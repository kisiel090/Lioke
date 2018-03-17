extends Node

func distance(from, to):
	var a = global.map.world_to_map(from) - global.map.world_to_map(to)
	#WOW WOW VECTOR MATHS WOW WOW
	if abs(a.x) > abs(a.y):
		return abs(a.x)
	else:
		return abs(a.y)
	pass