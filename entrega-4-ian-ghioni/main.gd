extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.set_projectile_container_and_map(self, $Map)
	$Enemy.set_values(self)
	$Enemy2.set_values(self)
	$Enemy3.set_values(self)
	$Enemy4.set_values(self)
	$Enemy5.set_values(self)
