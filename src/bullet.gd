extends Area3D

var dir = Vector3.MODEL_RIGHT



func _physics_process(delta: float) -> void:
	self.position+=dir*100*delta
	print(self.position)


func _on_timer_timeout() -> void:
	queue_free()
