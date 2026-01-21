class_name base extends Node3D



var max_health = 100
@onready var health = max_health :
	set(new_health):
		health=new_health
		label_3d.text=str(new_health)+"/"+str(max_health)
		label_3d.modulate = Color.RED.lerp(Color.WHITE,health/(max_health*1.0))



@onready var label_3d: Label3D = $Label3D

	


func take_damge(damge:int):
	pass
