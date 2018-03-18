extends TileMap

export (PackedScene) var player

func _ready():
	
	global.map = self
	var pl = player.instance()
	add_child(pl)
	pl.position = map_to_world(Vector2(2, 2))
	$FogMap._on_player_position_changed()
	
	var enemy = load("res://scenes/Objects/Enemy.tscn")
	var ll = enemy.instance()
	add_child(ll)
	ll.position = map_to_world(Vector2(2, 4))
	
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
	var occlusion_datamap = []
	
	for x in range(global.MAP_SIZE.x):
		occlusion_datamap.append([])
		for y in range(global.MAP_SIZE.y):
			if is_wall(self.get_cellv(Vector2(x, y))):
				occlusion_datamap[x].append(1)
			else:
				occlusion_datamap[x].append(0)
	
	for object in get_tree().get_nodes_in_group("occluders"):
		occlusion_datamap[object.x][object.y] = 1
	
	return occlusion_datamap
	pass

func is_passable(cell):
	var passable = true
	for tile in cnst.walls:
		if global.map.get_cellv(cell) == tile:
			passable = false
	for object in global.map.get_objects_in_cell(cell):
		if object.impassable:
			passable = false
	return passable
	pass



func is_wall(cellv):
	for wall in cnst.walls:
		if cellv == wall:
			return true
	return false
	pass