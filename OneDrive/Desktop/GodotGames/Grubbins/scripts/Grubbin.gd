extends CharacterBody2D

const base_speed = 80.0
var health = 10
@onready var animated_sprite = $AnimatedSprite2D
@onready var pause_screen = $"../GUI/pause_screen"
@onready var health_bar = $HealthBar
@onready var poison_crystal = $"../poison_crystal"
@onready var poison_timer = $"../poison_crystal/poison_timer"
@onready var sustenance_timer = $"../Game Manager/sustenance_timer"
@onready var game_manager = %"Game Manager"
@onready var sprint_timer = $sprint_timer

func _ready():
	health_bar.init_health(health)

func _physics_process(_delta):
	if Input.is_action_just_pressed("pause"):
		if pause_screen.visible == false:
			Engine.time_scale = 0
			pause_screen.visible = true
		else:
			Engine.time_scale = 1
			pause_screen.visible = false
			
	if Input.is_action_pressed("sprint"):
		if sprint_timer.is_stopped:
			sprint_timer.start()
	else:
		sprint_timer.stop()
			
#Handle Movement
	var horizontal = Input.get_axis("move_left", "move_right")
	if horizontal:
		if Input.is_action_pressed("sprint"):
			velocity.x = horizontal * base_speed * 1.5
		else: 
			velocity.x = horizontal * base_speed
	else:
		velocity.x = move_toward(velocity.x, 0, base_speed)
		
	var vertical = Input.get_axis("move_up", "move_down")
	if vertical:
		if Input.is_action_pressed("sprint"):
			velocity.y = vertical * base_speed * 1.5
		else: 
			velocity.y = vertical * base_speed
	else:
		velocity.y = move_toward(velocity.y, 0, base_speed)		

	move_and_slide()
	
# Orient the sprite
	if horizontal == 0 && vertical == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("move")
	if horizontal > 0 && vertical == 0:
		animated_sprite.rotation_degrees = 270
	if horizontal < 0 && vertical == 0:
		animated_sprite.rotation_degrees = 90
	if horizontal == 0 && vertical > 0:
		animated_sprite.rotation_degrees = 0
	if horizontal == 0 && vertical < 0:
		animated_sprite.rotation_degrees = 180
#diagonal
	if horizontal > 0 && vertical > 0:
		animated_sprite.rotation_degrees = 315
	if horizontal > 0 && vertical < 0:
		animated_sprite.rotation_degrees = 225
	if horizontal < 0 && vertical > 0:
		animated_sprite.rotation_degrees = 45
	if horizontal < 0 && vertical < 0:
		animated_sprite.rotation_degrees = 135
	#Play animation
	
#damage
func _on_poison_crystal_body_entered(_body):
	_set_health(-1)
	print("You are Poisoned! You took 1 poison damage immediately and will continue to lose health until the poison is neutralized")
	#health_bar.set_bg_color(.13, .93, .10, 1)
	health_bar._set_bg_color(Color(0.4, 0.2, 0.6, 1))
	#health_bar._set_bg_color(Color.REBECCA_PURPLE)
	#print(health)

func _on_poison_timer_timeout():
	_set_health(-1)
	print("poison damage: -1 health")
	
	
func _set_health(value):
	health += value
	if health <= 0:
		_die()
		
	health_bar.health = health
	
#death
func _die():
	animated_sprite.play("death")
	#if larvae:
		#for larvae in larvae
		#larvae.get_position.x = x
		#larvae.get_position.y = y
		#sort larvae for the closest
		#queue_free() the larvae. 
		#Start player at full health at position x,y
	#else:
	get_tree().reload_current_scene()
	
