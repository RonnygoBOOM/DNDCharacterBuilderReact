extends Control
@onready var pause_screen = $"."


func _on_resume_pressed():
	Engine.time_scale = 1
	pause_screen.visible = false


#func _on_options_pressed():
	#get_tree().change_scene_to_file("res://scenes/game_options_menu.tscn")


#func _on_save_game_pressed():
	#pass # Replace with function body.


func _on_quit_game_pressed():
	get_tree().quit()
