extends Node3D


func _ready() -> void:
	var base_obj:base= get_tree().get_first_node_in_group("base")
	base_obj.health=base_obj.max_health
