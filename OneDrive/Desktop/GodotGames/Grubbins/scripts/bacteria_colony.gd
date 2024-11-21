extends Area2D

@onready var game_manager = %"Game Manager"
@onready var animation_player = $AnimationPlayer


func _on_body_entered(_body):
	game_manager.add_sustenance()
	animation_player.play("Pickup")
