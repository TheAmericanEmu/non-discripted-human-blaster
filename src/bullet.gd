extends Area3D

var dir = Vector3.MODEL_RIGHT

var damage =30

func _physics_process(delta: float) -> void:
	self.position+=dir*200*delta
	


func _on_timer_timeout() -> void:
	queue_free()


func _on_area_entered(area: Area3D) -> void:
	var par_of_enemy =area.get_parent_node_3d()
	print(par_of_enemy.health)
	if  par_of_enemy is enemy:
		par_of_enemy.health-=damage
		self.queue_free()
		
