extends Node
#class for calculations of field of view

func get_cells_in_fov(origin, radius, occlusion_data):
	
	var edge_points = rglib.get_circle(origin, radius)
	
	var cellsfov = [origin]
	
	for cirpoint in edge_points:
		var ray = cast_fov_ray(origin, cirpoint, occlusion_data)
		for fovpoint in ray:
			if cellsfov.find(fovpoint) == -1:
				cellsfov.append(fovpoint)
	return cellsfov
	pass

func cast_fov_ray(origin, cell, occlusion_data):
	var line = rglib.get_line(origin, cell)
	#remove points out of map to prevent access error
	var i = 0
	while i < line.size():
		if line[i].x < 0 or line[i].x >= global.MAP_SIZE.x or line[i].y < 0 or line[i].y >= global.MAP_SIZE.y:
			line.remove(i)
		i += 1
	
	var fovpoints = []
	for cell in line: 
		if not occlusion_data[cell.x + global.MAP_SIZE.x * cell.y]:
			fovpoints.append(cell)
		else:
			fovpoints.append(cell)
			break
	return fovpoints
	pass


#I'm leaving this code for me in the future, to remember myself to not work 4h a day...
#	var points = rglib.get_line(origin, cell)
#	#remove points out of map to prevent access error KLUDGE
#	var i = 0
#	while i < points.size():
#		if points[i].x < 0 or points[i].x >= global.MAP_SIZE.x or points[i].y < 0 or points[i].y >= global.MAP_SIZE.y:
#			points.remove(i)
#		i += 1
#	for cell in points: 
#		if not occlusion_data[cell.x][cell.y]:
#			points.append(cell)
#		else:
#			break
#	return points
