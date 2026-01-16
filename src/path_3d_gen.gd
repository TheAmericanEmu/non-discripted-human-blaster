extends Path3D
#@onready var csg_polygon_3d: CSGPolygon3D = $CSGPolygon3D
@onready var path_follow_3d: PathFollow3D = $PathFollow3D

func _ready() -> void:
	var noise = FastNoiseLite.new()
	
	var new_curve = Curve3D.new()
	new_curve.closed=false
	for i in range(100):
		var y = noise.get_noise_1d(i)
		
		new_curve.add_point(Vector3(y*-20,0,i*2))
	new_curve.sample_baked()
	
	print(new_curve.point_count)
	self.curve=new_curve
