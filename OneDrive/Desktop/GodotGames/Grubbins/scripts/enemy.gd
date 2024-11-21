extends Node2D
const SPEED = 50
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D

var direction = 1
func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_v = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_v = false



	position.x += direction * SPEED * delta
	
