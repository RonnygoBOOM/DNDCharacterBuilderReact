extends Node2D

#@onready var interaction_area: InteractionArea = $InteractionArea
@onready var interaction_area = $InteractionArea

func _ready():
	interaction_area.interact = Callable(self, "_lay_egg")
	
func _lay_egg():
	print("_lay_egg")
