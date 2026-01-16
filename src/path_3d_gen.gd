extends Path3D
@onready var csg_polygon_3d: CSGPolygon3D = $Path3D/CSGPolygon3D

func _ready() -> void:
	var noise = FastNoiseLite.new()
	
	var new_curve = Curve3D.new()
	new_curve.closed=true
	for i in range(100):
		var y = noise.get_noise_1d(i)
		
		new_curve.add_point(Vector3(i,0,y*1000))

	print(new_curve.point_count)
	self.curve=new_curve
