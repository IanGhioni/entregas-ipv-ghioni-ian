extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.set_projectile_container(self)
	$Turret.set_values(self)
	$Turret2.set_values(self)
	$Turret3.set_values(self)
	$Turret4.set_values(self)
	$Turret5.set_values(self)
