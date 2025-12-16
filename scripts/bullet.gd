extends Sprite2D

@onready var RayCast: RayCast2D = $RayCast2D
var speed = 250

func _physics_process(delta):
	global_position += Vector2(1,0).rotated(rotation) * speed * delta
	if RayCast.is_colliding() and !RayCast.get_collider().get("IS_PLAYER"):
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	# Deletes the bullet when it exits the screen.
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	pass # Replace with function body.
