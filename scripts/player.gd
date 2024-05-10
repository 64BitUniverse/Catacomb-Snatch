extends CharacterBody2D

@export var speed = 130
@onready var _animated_sprite = $AnimatedSprite2D

func get_input():
	
	var input_direction = Input.get_vector("left", "right", "up", "down")
	#print(get_global_mouse_position() - position)
	#print(get_local_mouse_position() - position)	
	
	velocity = input_direction * speed

func _process(delta):
	var mouse = get_global_mouse_position() - position
	
	#If animations are glitching, add advance(0) after .play
	#It's an issue with the timing of AnimationPlayer getting called.
	if mouse.angle() < 7*PI/8 && mouse.angle() > 5*PI/8:
		_animated_sprite.play("FrontLeft")
	elif mouse.angle() <= 5*PI/8 && mouse.angle() >= 3*PI/8:
		_animated_sprite.play("Front")
	elif mouse.angle() < 3*PI/8 && mouse.angle() > PI/8:
		_animated_sprite.play("FrontRight")
	elif mouse.angle() <= PI/8 && mouse.angle() >= -PI/8:
		_animated_sprite.play("Right")
	elif mouse.angle() < -PI/8 && mouse.angle() > -3*PI/8:
		_animated_sprite.play("BackRight")
	elif mouse.angle() <= -3*PI/8 && mouse.angle() >= -5*PI/8:
		_animated_sprite.play("Back")
	elif mouse.angle() < -5*PI/8 && mouse.angle() > -7*PI/8:
		_animated_sprite.play("BackLeft")
	elif abs(mouse.angle()) >= 7*PI/8:
			_animated_sprite.play("Left")

func _physics_process(delta):
	get_input()
	move_and_slide()
