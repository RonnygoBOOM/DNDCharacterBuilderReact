extends Node

@onready var energy_label = $"../Grubbin/Energy Label"
@onready var reproduction_label = $"../Grubbin/Reproduction Label"
@onready var sustenance_label = $"../Grubbin/Camera2D/Panel/sustenance_label"
@onready var sustenance_timer = $sustenance_timer
@onready var sprint_timer = $"../Grubbin/sprint_timer"

var energy = 0
var sustenance = 10

func add_sustenance():
	sustenance += 1
	sustenance_label.text = "" + str(sustenance)
	if sustenance >= 20:
		reproduction_enabled()
	
#func add_energy():
	#energy += 1W
	#energy_label.text = "Energy: " + str(energy)
	#if energy >= 1:
		#reproduction_enabled()
		
func reproduction_enabled():
	print("Reproduction process begins.  Offer option to reproduce sexually or asexually. If sexually, make eggs, offer choice of embryos with a normalized curve for each trait")
	reproduction_label.text = "Reproduce"



func _on_sprint_timer_timeout():
	sustenance -= 1
	sustenance_label.text = "" + str(sustenance)
	print("-1 sustenance from sprinting timer")
	#sprint_timer.one_shot = false
	

func _on_sustenance_timer_timeout():
	sustenance -= 1
	print("-1 sustenance from timer")
	sustenance_label.text = "" + str(sustenance)
