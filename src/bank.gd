class_name bank extends MarginContainer
@onready var label: Label = $Label

@onready var money:int =250:
	set(new_value):
		money=new_value
		label.text="Gold: "+str(money)
