extends PathFollow3D


@export var speed = 100



func _process(delta: float) -> void:
	var base_OBJ :base= get_tree().get_first_node_in_group("base")

	progress+=speed*delta
	if progress_ratio==1:
		base_OBJ.health-=10
		self.queue_free()
	
