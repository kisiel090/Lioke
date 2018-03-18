extends Node

func distance(from, to):
	var a = global.map.world_to_map(from) - global.map.world_to_map(to)
	#WOW WOW VECTOR MATHS WOW WOW
	if abs(a.x) > abs(a.y):
		return abs(a.x)
	else:
		return abs(a.y)
	pass

func get_line(origin, to):
	var points = []
	var xi
	var yi
	var dx
	var dy
	var ai
	var bi
	var d
	var x = origin.x
	var y = origin.y
	
	if origin.x < to.x:
		xi = 1
		dx = to.x - origin.x
	else:
		xi = -1
		dx = origin.x - to.x
	
	if origin.y < to.y:
		yi = 1
		dy = to.y - origin.y
	else:
		yi = -1
		dy = origin.y - to.y
	
	points.append(Vector2(x, y))
	
	if (dx > dy):
		ai = (dy - dx) * 2
		bi = dy * 2
		d = bi - dx
		while x != to.x:
			if d >= 0:
				x += xi
				y += yi
				d += ai
			else:
				d += bi
				x += xi
			points.append(Vector2(x, y))
	else:
		ai = (dx - dy) * 2
		bi = dx * 2
		d = bi - dy
		while y != to.y:
			if d >= 0:
				x += xi
				y += yi
				d += ai
			else:
				d += bi
				x += xi
			points.append(Vector2(x, y))
	return points
	pass

func get_circle(origin, radius):
	
	var points = []
	var x = radius
	var y = 0
	var dx = 1
	var dy = 1
	var err = dx - radius * 2
	
	while x >= y:
		
		points.append(Vector2(origin.x + x, origin.y + y))
		points.append(Vector2(origin.x + y, origin.y + x))
		points.append(Vector2(origin.x - x, origin.y + y))
		points.append(Vector2(origin.x - y, origin.y + x))
		points.append(Vector2(origin.x + x, origin.y - y))
		points.append(Vector2(origin.x + y, origin.y - x))
		points.append(Vector2(origin.x - x, origin.y - y))
		points.append(Vector2(origin.x - y, origin.y - x))
		
		if err <= 0:
			y += 1
			err += dy
			dy += 2
		if err > 0:
			x -= 1
			dx += 2
			err += dx - radius * 2
	
	return points
	pass