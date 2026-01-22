extends Path3D
#@onready var csg_polygon_3d: CSGPolygon3D = $CSGPolygon3D

const BASE = preload("uid://bgt7yjova1cs0")
@onready var grid_map: GridMap = $"../GridMap"
const ENEMY = preload("uid://bqnvijg310h7o")




func _ready() -> void:
	randomize()
	var noise = FastNoiseLite.new()
	noise.seed=randi_range(0,10000000)
	var new_curve = Curve3D.new()
	new_curve.closed=false
	for i in range(90):
		var y = noise.get_noise_1d(i)

		var point = Vector3((y*-60),0,i*2)
		new_curve.add_point(point)
		var grid_point = grid_map.local_to_map(point)
		print(grid_point)
		grid_point.x+=3
		grid_map.set_cell_item(grid_point,0,6)
		grid_point.x-=6
		grid_map.set_cell_item(grid_point,0,6)
	new_curve.sample_baked()
	var tower:base = BASE.instantiate()
	
	
	print(new_curve.point_count)
	
	var last_ponit:=new_curve.get_point_position(new_curve.point_count-1)
	var last_point_out :=new_curve.get_point_out(new_curve.point_count-1)
	get_tree().current_scene.add_child.call_deferred(tower)
	
	tower.global_position=last_ponit
	tower.position.y+=5
	
	var flat_point: = tower.position
	flat_point.y=0
	print(flat_point.angle_to(last_point_out))
	
	self.curve=new_curve
	for i in range(5):
		await get_tree().create_timer(1).timeout
		_add_enemy()

func _add_enemy():
	var new_bad_guy = ENEMY.instantiate()
	self.add_child(new_bad_guy)

func _process(delta: float) -> void:
	if get_tree().get_node_count_in_group("enemy")<5:
		_add_enemy()
