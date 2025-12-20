extends Node2D

@onready var GameManager = %GameManager
@onready var RayCast: RayCast2D = $RayCast2D
@onready var player = get_node("/root/Game/Lard")

var areaname = ""

func _on_area_entered(area):
	areaname = area.name

func _physics_process(delta):
	if areaname == "CoinVac":
		position = position.move_toward(player.position, delta * 250)
		
	if RayCast.is_colliding() and RayCast.get_collider().get("IS_PLAYER"): # or RayCast.get_collider().get("IS_VACUUM"):
		GameManager.coin_pickup(10)
		queue_free()
