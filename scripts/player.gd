extends CharacterBody2D

const IS_PLAYER = true

@onready var GameManager = %GameManager
@onready var _character = $Character
#onready var hit_as_ref = $Hit
@onready var MuzzleVec2: Vector2 = Vector2()
@onready var MuzzleOffset: Vector2 = Vector2() # GLOBAL REFERENCE (global_position). DO NOT COMPARE TO SCENE.
@onready var MuzzleSprite: AnimatedSprite2D = $MuzzleSprite
@onready var RotationTrack: Node2D = $RotationTrack
@onready var MuzzleSpawn: Marker2D = $RotationTrack/MuzzleSpawn
@onready var CoinVac: Area2D = $"CoinVac"
@onready var CoinParticles: CPUParticles2D = $"BigShine"
@onready var CoinParticlesS: CPUParticles2D = $"SmallShine"

var bullet_default = preload("res://scenes/bullet.tscn")
var coin_bronze = preload("res://scenes/coin_bronze.tscn")
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
		MuzzleVec2 = Vector2(-8, 10)
		MuzzleOffset = Vector2(0,12)
	elif mouse.angle() <= 5*PI/8 && mouse.angle() >= 3*PI/8:
		_character.play("Front")
		MuzzleVec2 = Vector2(3, 11)
		MuzzleOffset = Vector2(10,7)
	elif mouse.angle() < 3*PI/8 && mouse.angle() > PI/8:
		_character.play("FrontRight")
		MuzzleVec2 = Vector2(8, 10)
		MuzzleOffset = Vector2(8,0)
	elif mouse.angle() <= PI/8 && mouse.angle() >= -PI/8:
		_character.play("Right")
		MuzzleVec2 = Vector2(14,6)
		MuzzleOffset = Vector2(0,0)
	elif mouse.angle() < -PI/8 && mouse.angle() > -3*PI/8:
		_character.play("BackRight")
		MuzzleVec2 = Vector2(12, -2)
		MuzzleOffset = Vector2(0,0)
	elif mouse.angle() <= -3*PI/8 && mouse.angle() >= -5*PI/8:
		_character.play("Back")
		MuzzleVec2 = Vector2(0, -19)
		MuzzleOffset = Vector2(-5,-5)
	elif mouse.angle() < -5*PI/8 && mouse.angle() > -7*PI/8:
		_character.play("BackLeft")
		MuzzleVec2 = Vector2(-12, -2)
		MuzzleOffset = Vector2(-15,0)
	elif abs(mouse.angle()) >= 7*PI/8:
		_character.play("Left")
		MuzzleVec2 = Vector2(-14, 6)
		MuzzleOffset = Vector2(-2,12)
		
func shoot():
	if true:
		var new_bullet = bullet_default.instantiate()
		print(MuzzleSpawn.global_position)
		var MuzzleSpawnP = MuzzleSpawn.global_position + MuzzleOffset
		new_bullet.global_position = MuzzleSpawnP
		new_bullet.global_rotation = MuzzleSpawn.global_rotation
		# Bullet speed in bullet.gd
		MuzzleSprite.position = MuzzleVec2
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
	get_input()
	move_and_slide()
	
func _on_game_manager_coin_destruct():
	CoinParticles.emitting = true
