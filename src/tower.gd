extends MeshInstance3D
@onready var turret: MeshInstance3D = $Turret
@export var bullet:PackedScene
@onready var timer: Timer = $Timer
@onready var csg_baked_mesh_instance_3d_2: MeshInstance3D = $Turret/CSGBakedMeshInstance3D2

var can_shoot= false

func _ready() -> void:
	timer.timeout.connect(func():
		can_shoot=true
	)

func _process(delta: float) -> void:
	var enemeys = get_tree().get_nodes_in_group("enemy")

	var target:Node3D=null
	if enemeys !=null and target==null:
		var closets:Node3D=enemeys[0]
		for enemey:Node3D in enemeys:
				if enemey.position.distance_to(self.position) < closets.position.distance_to(self.position):
					closets=enemey
		target=closets
		
		
				
	if target!=null:
		if target.position.distance_to(self.position)<20:
			turret.look_at(target.position)
			if can_shoot==true:
				var bullet_obj:Node3D = bullet.instantiate()
				add_child(bullet_obj)
				bullet_obj.global_position=csg_baked_mesh_instance_3d_2.global_position
				bullet_obj.dir=-turret.global_basis.z
				can_shoot=false

		else:
			target=null
			turret.rotation=Vector3(0,0,0)
