extends TileMap

export (PackedScene) var player

func _ready():
	global.map = self
	var pl = player.instance()
	add_child(pl)
	pl.position = map_to_world(Vector2(2, 2))
	
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