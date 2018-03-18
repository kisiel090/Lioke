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
	var xline = origin.x
	var yline = origin.y
	
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
	
	points.append(Vector2(xline, yline))
	
	if (dx > dy):
		ai = (dy - dx) * 2
		bi = dy * 2
		d = bi - dx
		while xline != to.x:
			if d >= 0:
				xline += xi
				yline += yi
				d += ai
			else:
				d += bi
				xline += xi
			points.append(Vector2(xline, yline))
	else:
		ai = (dx - dy) * 2
		bi = dx * 2
		d = bi - dy
		while yline != to.y:
			if d >= 0:
				xline += xi
				yline += yi
				d += ai
			else:
				d += bi
				yline += yi
			points.append(Vector2(xline, yline))
	return points
	pass

func get_circle(origin, radius):
	
	var points = []
	var xcir = radius
	var ycir = 0
	var dx = 1
	var dy = 1
	var err = dx
	err -= radius
	err -= radius
	
	while xcir >= ycir:
		
		points.append(Vector2(origin.x + xcir, origin.y + ycir))
		points.append(Vector2(origin.x + ycir, origin.y + xcir))
		points.append(Vector2(origin.x - xcir, origin.y + ycir))
		points.append(Vector2(origin.x - ycir, origin.y + xcir))
		points.append(Vector2(origin.x + xcir, origin.y - ycir))
		points.append(Vector2(origin.x + ycir, origin.y - xcir))
		points.append(Vector2(origin.x - xcir, origin.y - ycir))
		points.append(Vector2(origin.x - ycir, origin.y - xcir))
		
		if err <= 0:
			ycir += 1
			err += dy
			dy += 2
		if err > 0:
			xcir -= 1
			dx += 2
			err += dx - radius * 2
	
	return points
	pass