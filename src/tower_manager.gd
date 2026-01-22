class_name turrent_manger extends Node

@export var turret:PackedScene


func _build_turret(pos:Vector3):
	var new_turrent:Node3D = turret.instantiate()
	print(pos)
	add_child(new_turrent)
	
	new_turrent.global_position=pos
	new_turrent.position.y+=2
	new_turrent.scale=Vector3(2,2,2)
