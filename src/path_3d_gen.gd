extends Path3D
#@onready var csg_polygon_3d: CSGPolygon3D = $CSGPolygon3D
@onready var camera_3d: Camera3D = $"../Camera3D"

const BASE = preload("uid://bgt7yjova1cs0")
@onready var grid_map: GridMap = $"../GridMap"
const ENEMY = preload("uid://bqnvijg310h7o")
@onready var timer: Timer = $Timer
@export var bank_obj:bank
var total_num_emenies=1000
@export var money_per_kill := 50
@onready var allow_spawning := false
@export var diff_manger_obj:diff_manger


func _ready() -> void:
	randomize()
	
	timer.timeout.connect(func():
		if get_tree().get_node_count_in_group("enemy")<total_num_emenies:
			_add_enemy()
		)
	
	
	var noise = FastNoiseLite.new()
	noise.seed=randi_range(0,10000000)
	var new_curve = Curve3D.new()
	new_curve.closed=false
	for i in range(30):
		var y = noise.get_noise_1d(i)

		var point = Vector3((y*-60),0,i*5)
		new_curve.add_point(point)
		var grid_point = grid_map.local_to_map(point)
		print(grid_point)
		grid_point.x+=3
		grid_map.set_cell_item(grid_point,0,6)
		grid_point.x-=6
		grid_map.set_cell_item(grid_point,1,6)
	new_curve.sample_baked()
	var tower:base = BASE.instantiate()
	

	print(new_curve.point_count)
	
	var last_ponit:=new_curve.get_point_position(new_curve.point_count-1)
	var last_point_out :=new_curve.get_point_out(new_curve.point_count-1)
	get_tree().current_scene.add_child.call_deferred(tower)
	
	tower.global_position=last_ponit
	tower.position.y+=5

	
	var mid_point = new_curve.get_point_position(new_curve.point_count/2)
	camera_3d.position.x=mid_point.x-50
	camera_3d.position.z=mid_point.z+50
	
	var flat_point: = tower.position
	flat_point.y=0
	print(flat_point.angle_to(last_point_out))
	
	self.curve=new_curve
	timer.start()

func _add_enemy():
	timer.wait_time=diff_manger_obj.get_spawn_time()
	var new_bad_guy:enemy = ENEMY.instantiate()
	new_bad_guy.max_health=diff_manger_obj.get_heal_time()
	self.add_child(new_bad_guy)
	new_bad_guy.death.connect(func():
		bank_obj.money+=money_per_kill
		if timer.is_stopped():
			if get_tree().get_node_count_in_group("enemy")==0:
				print("you won")
	)
	


func _on_node_stop_spawning() -> void:
	timer.stop()
