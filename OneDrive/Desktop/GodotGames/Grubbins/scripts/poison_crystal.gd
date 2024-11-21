extends Area2D

@onready var poison_timer = $poison_timer
@onready var grubbin = $"."
var poison_counter = 2



func _on_body_entered(_body):
	print("you have entered poison!")
	poison_timer.start()


func _on_poison_timer_timeout():
	if poison_counter >= 1:
		poison_counter -= 1
		print("the poison is damaging you")
	else:
		#poison_timer.set_one_shot(true)
		poison_timer.stop()
		print("you have neutralized the poison")
		poison_counter = 2
		
