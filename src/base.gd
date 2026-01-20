class_name base extends Node3D



var max_health = 100
@onready var health = max_health


@onready var label_3d: Label3D = $Label3D

	


func take_damge(damge:int):
	health-=damge
	label_3d.text=str(health)+"/"+str(max_health)
