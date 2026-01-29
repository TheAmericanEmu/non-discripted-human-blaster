class_name win_screen extends CanvasLayer

@onready var star_2: TextureRect = %Star2
@onready var star_3: TextureRect = %Star3

@onready var prefect_run: Label = $CenterContainer/Panel/VBoxContainer/Prefect_Run
@onready var money: Label = $CenterContainer/Panel/VBoxContainer/Money


func _on_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_button_2_pressed() -> void:
	get_tree().quit()


func _on_visibility_changed() -> void:
	if visible==true:
		var base_obj:base = get_tree().get_first_node_in_group("base")
		var bank_obj:bank = get_tree().get_first_node_in_group("bank")
		if base_obj!=null:
			if base_obj.health==base_obj.max_health:
				star_2.modulate.a=255
				prefect_run.show()
		if bank_obj.money>100:
			if star_2.modulate.a==255:
				star_3.modulate.a=255
			else:
				star_2.modulate.a=255
			money.show()
