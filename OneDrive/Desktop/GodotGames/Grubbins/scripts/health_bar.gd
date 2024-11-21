extends ProgressBar

@onready var timer = $Timer
@onready var damage_bar = $DamageBar
@onready var health_bar = $"."


var health = 10 : set = _set_health
@export var bar_color := Color(0.6, 0.6, 0.6, 1) : set = _set_bg_color


func _set_health(new_health):
	var prev_health = health
	health = min(max_value, new_health)
	value = health
	
	if health <= 0:
		queue_free()
		
	if health < prev_health:
		timer.start()
	else:
		damage_bar.value = health

func _set_bg_color(new_color):
	print(new_color)
	# This is correctly passing the color, but it is NOT setting it correctly
	#health_bar.set_bg_color = new_color
	
func init_health(_health):
	health = _health
	max_value = health
	value = health
	damage_bar.max_value = health
	damage_bar.value = health

func _on_timer_timeout():
	damage_bar.value = health
