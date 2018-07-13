extends TileMap

export (PackedScene) var player
export (PackedScene) var enemy
onready var occlusion_datamap = []
var astar_graph

func _enter_tree():
	global.map = self

func _ready():
	
	$FogMap._on_player_position_changed()
	astar_graph = _initiate_astar()
	
	pass

func get_objects_in_cell(cell):
	var objects = []
	for object in get_tree().get_nodes_in_group("objects"):
		if object.get_parent() == self and object.get_map_pos() == cell:
			objects.append(object)
	return objects
	pass

func _on_player_acted():
	for actor in get_tree().get_nodes_in_group("actors"):
		if actor != global.player and actor.controller:
			actor.controller.act()
	
	pass

func get_occlusion_datamap():
	occlusion_datamap = []
	for yoccl in range(global.MAP_SIZE.y):
		for xoccl in range(global.MAP_SIZE.x):
			var mhm = is_wall(Vector2(xoccl, yoccl))
			if mhm:
				occlusion_datamap.append(1)
			else:
				occlusion_datamap.append(0)
	

	for object in get_tree().get_nodes_in_group("occluders"):
		occlusion_datamap[global.MAP_SIZE.x * object.y + object.x] = 1

	return occlusion_datamap
	pass

func is_passable(cell):
	var passable = true
	for tile in cnst.walls:
		if global.map.get_cellv(cell) == tile:
			passable = false
	var gl = global.map.get_objects_in_cell(cell)
	for object in gl:
		if object.impassable:
			passable = false
	return passable
	pass



func is_wall(cellv):
	for wall in cnst.walls:
		if get_cellv(cellv) == wall:
			return true
	return false
	pass

func _initiate_astar():	#initiate A* graph
	var graph = AStar.new()
	for y in global.MAP_SIZE.y:
		for x in global.MAP_SIZE.x:
			graph.add_point(x + global.MAP_SIZE.x * y, Vector3(x, y, 0))
	
	for y in global.MAP_SIZE.y:
		for x in global.MAP_SIZE.x:
			#	OOO
			#	OoX 
			#	XXX
			if !is_wall(Vector2( x , y )):
				if !is_wall(Vector2( x + 1 , y + 1 )):
					graph.connect_points(x + global.MAP_SIZE.x * y, x + 1 + global.MAP_SIZE.x * (y + 1))
				if !is_wall(Vector2( x - 1 , y + 1 )):
					graph.connect_points(x + global.MAP_SIZE.x * y, x - 1 + global.MAP_SIZE.x * (y + 1))
				if !is_wall(Vector2( x , y + 1 )):
					graph.connect_points(x + global.MAP_SIZE.x * y, x + global.MAP_SIZE.x * (y + 1))
				if !is_wall(Vector2( x + 1 , y )):
					graph.connect_points(x + global.MAP_SIZE.x * y, x + 1 + global.MAP_SIZE.x * y )
	return graph

