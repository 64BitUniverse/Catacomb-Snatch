extends CharacterBody2D

@export var speed = 130
@onready var _animated_sprite = $AnimatedSprite2D

func get_input():
	print()
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _process(delta):
	#If animations are glitching, add advance(0) after .play
	#It's an issue with the timing of AnimationPlayer getting called.
	if (get_global_mouse_position() - position) > Vector2(0,0):
		_animated_sprite.play("Right")
	elif (get_global_mouse_position() - position) < Vector2(-0,0):
		_animated_sprite.play("Left")
	elif (get_global_mouse_position() - position) < Vector2(0, -0):
		_animated_sprite.play("Up")
	elif (get_global_mouse_position() - position) < Vector2(-0, -0):
		_animated_sprite.play("Down")



func _physics_process(delta):
	get_input()
	move_and_slide()
