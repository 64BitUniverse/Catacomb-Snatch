extends Node2D

@onready var RayCast: RayCast2D = $RayCast2D
@onready var player = get_node("/root/Game/Lard")

var areaname = ""

func _on_area_entered(area):
	print(area.name)
	areaname = area.name

func _physics_process(delta):
	if areaname == "CoinVac":
		position = position.move_toward(player.position, delta * 250)
		
	if RayCast.is_colliding() and RayCast.get_collider().get("IS_PLAYER"):
		queue_free()
