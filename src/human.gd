extends PathFollow3D


@export var speed = 100

func _process(delta: float) -> void:
	progress+=speed*delta
