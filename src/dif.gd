class_name diff_manger extends Node



@export var spawn_diff_curve:Curve
@export var health_diff_curve:Curve
@onready var timer: Timer = $Timer

@export var game_length:int=30


signal stop_spawning

func _get_progess_ratio()->float:
	return 1.0-(timer.time_left/game_length)

func get_spawn_time():
	return spawn_diff_curve.sample(_get_progess_ratio())
func get_heal_time():
	return health_diff_curve.sample(_get_progess_ratio())

func _ready() -> void:
	timer.start(game_length)
	timer.timeout.connect(func():
		
		stop_spawning.emit()
		)
