extends Area2D

@onready var killzone_timer = $"Killzone Timer"


func _on_body_entered(_body):
	print("you are dying!")
	killzone_timer.start()


func _on_killzone_timer_timeout():
	pass
	
