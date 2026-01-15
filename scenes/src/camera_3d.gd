extends Camera3D


@onready var grid_map: GridMap = $"../GridMap"

func find_click_pos():
	var space_state = get_world_3d().direct_space_state
	var cam = self
	var mousepos = get_viewport().get_mouse_position()
	var origin = cam.project_ray_origin(mousepos)
	var end = origin + cam.project_ray_normal(mousepos) * 100000
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collision_mask=2
	query.collide_with_bodies=true
	query.collide_with_areas = false
	var result = space_state.intersect_ray(query)
	if result:
		var pos = result["position"]
		self.look_at(pos)


func _ready() -> void:
	print(grid_map.get_cell_item(Vector3i(0,0,0)))
	grid_map.set_cell_item(Vector3i(0,0,0),0)
