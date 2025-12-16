extends CharacterBody2D

const IS_PLAYER = true
@onready var _character = $Character
#Originally 'rotation', but apparently that's reserved
#This is just to store Character Rotation for bullets and things
@onready var CRotate: String = ""
@onready var RotationTrack: Node2D = $RotationTrack
@onready var MuzzleSpawn: Marker2D = $RotationTrack/MuzzleSpawn
@onready var MuzzleSprite: AnimatedSprite2D = $RotationTrack/MuzzleSprite
var bullet_default = preload("res://scenes/bullet.tscn")
var speed = 100

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _process(delta):

	var mouse = get_global_mouse_position() - position
	#If animations are glitching, add advance(0) after .play
	#It's an issue with the timing of AnimationPlayer getting called.
	if mouse.angle() < 7*PI/8 && mouse.angle() > 5*PI/8:
		_character.play("FrontLeft")
		CRotate = "FrontLeft"
	elif mouse.angle() <= 5*PI/8 && mouse.angle() >= 3*PI/8:
		_character.play("Front")
		CRotate = "Front"
	elif mouse.angle() < 3*PI/8 && mouse.angle() > PI/8:
		_character.play("FrontRight")
		CRotate = "FrontRight"
	elif mouse.angle() <= PI/8 && mouse.angle() >= -PI/8:
		_character.play("Right")
		CRotate = "Right"
	elif mouse.angle() < -PI/8 && mouse.angle() > -3*PI/8:
		_character.play("BackRight")
		CRotate = "BackRight"
	elif mouse.angle() <= -3*PI/8 && mouse.angle() >= -5*PI/8:
		_character.play("Back")
		CRotate = "Back"
	elif mouse.angle() < -5*PI/8 && mouse.angle() > -7*PI/8:
		_character.play("BackLeft")
		CRotate = "BackLeft"
	elif abs(mouse.angle()) >= 7*PI/8:
		_character.play("Left")
		CRotate = "Left"
func shoot():
	if true:
		var new_bullet = bullet_default.instantiate()
		new_bullet.global_position = RotationTrack.global_position
		new_bullet.global_rotation = RotationTrack.global_rotation
		# Bullet speed in bullet.gd
		MuzzleSprite.play("default")
		get_parent().add_child(new_bullet)
	#FUTURE
	elif false:
		#For shotgun bullets. Need to have a value in player to
		#define weapons
		pass
	else:
		#For plasma bullets. Need to have a value in player to
		#define weapons
		pass

func _physics_process(delta):
	RotationTrack.rotation = lerp_angle(RotationTrack.rotation, (get_global_mouse_position() - global_position).angle(), 6.5*delta)
	MuzzleSprite.position = Vector2().rotated(-RotationTrack.rotation)
	get_input()
	move_and_slide()
