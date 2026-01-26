extends Camera3D


@export var grid_map: GridMap
@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var turrent_manger_obj: turrent_manger = $"../Turrent_Manger"
@export var bank_obj:bank
@export var cost_per_tower = 150


func find_click_pos():
	Input.set_default_cursor_shape(Input.CursorShape.CURSOR_ARROW)
	#var space_state = get_world_3d().direct_space_state
	#var cam = self
	#var mousepos = get_viewport().get_mouse_position()
	#var origin = cam.project_ray_origin(mousepos)
	#var end = origin + cam.project_ray_normal(mousepos) * 100
	#var query = PhysicsRayQueryParameters3D.create(origin, end)
	#query.collision_mask=2
	#query.collide_with_bodies=true
	#query.collide_with_areas = false
	#var result = space_state.intersect_ray(query)
	#if result:
		#var pos:Vector3 = result["position"]
		#return pos
	#return Vector3.ZER
	var mousepos = get_viewport().get_mouse_position()
	var target = self.project_local_ray_normal(mousepos)
	ray_cast_3d.target_position=target*100
	ray_cast_3d.force_raycast_update()

	if ray_cast_3d.get_collider()==grid_map:
		var pos = ray_cast_3d.get_collision_point()
		var grid_point = grid_map.local_to_map(pos)
		if grid_map.get_cell_item(grid_point)==0:
			Input.set_default_cursor_shape(Input.CursorShape.CURSOR_POINTING_HAND)
			if Input.is_action_just_pressed("place"):
				if bank_obj.money>=cost_per_tower:
					bank_obj.money-=cost_per_tower
					turrent_manger_obj._build_turret(grid_map.map_to_local(grid_point),Vector3(0,180,0))
					grid_map.set_cell_item(grid_point,-1)
		if grid_map.get_cell_item(grid_point)==1:
			Input.set_default_cursor_shape(Input.CursorShape.CURSOR_POINTING_HAND)
			if Input.is_action_just_pressed("place"):
				if bank_obj.money>=cost_per_tower:
					bank_obj.money-=cost_per_tower
					turrent_manger_obj._build_turret(grid_map.map_to_local(grid_point),Vector3(0,-180,0))
					grid_map.set_cell_item(grid_point,-1)
func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	find_click_pos()
