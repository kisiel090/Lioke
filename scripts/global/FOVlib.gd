extends Node
#class for calculations of field of view

func get_cells_in_fov(origin, radius, occlusion_data):
	
	var edge_points = rglib.get_circle(origin, radius)
	
	var cellsfov = []
	
	for cell in edge_points:
		cellsfov.append(cast_fov_ray(origin, cell, occlusion_data))
	return cellsfov
	pass

func cast_fov_ray(origin, cell, occlusion_data):
	var points = rglib.get_line(origin, cell)
	#remove points out of map to prevent access error KLUDGE
	var i = 0
	while i < points.size():
		if points[i].x < 0 or points[i].x >= global.MAP_SIZE.x or points[i].y < 0 or points[i].y >= global.MAP_SIZE.y:
			points.remove(i)
		i += 1
	
	var fovpoints = []
	for cell in points: 
		var ffff = occlusion_data[cell.x]
		if not ffff[cell.y]:
			fovpoints.append(cell)
		else:
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
