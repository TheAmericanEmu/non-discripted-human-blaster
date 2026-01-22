extends MeshInstance3D

func _process(delta: float) -> void:
	var enemeys = get_tree().get_nodes_in_group("enemy")
	print(enemeys)
	var closets:Node3D=null
	if enemeys !=null:
		for enemey:Node3D in enemeys:
			if closets == null or enemey.position.distance_to(self.position) < closets.position.distance_to(self.position):
				enemey=closets
	closets=null
