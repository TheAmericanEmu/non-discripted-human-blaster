class_name enemy extends PathFollow3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var speed = 20

@export var max_health :=50
@onready var health:=max_health:
	set(new_health):

		print(health)
		if health>new_health:
			animation_player.play("hit")
		health=new_health
		if health<=1:
			self.queue_free()


func _process(delta: float) -> void:
	var base_OBJ :base= get_tree().get_first_node_in_group("base")
	
	progress+=speed*delta
	if progress_ratio==1:
		base_OBJ.health-=10
		self.queue_free()
	
