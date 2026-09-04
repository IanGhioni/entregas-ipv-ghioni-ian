extends Sprite2D


var player 

@export var projectile_scene:PackedScene 
var projectile_container:Node

func set_values(player, projectile_container):
	self.player = player
	$Timer.start()
	self.projectile_container = projectile_container

	
func fire():
	var projectile:Projectile = projectile_scene.instantiate()
	projectile_container.add_child(projectile)
	projectile.set_starting_values($Marker2D.global_position, (player.global_position - $Marker2D.global_position).normalized())
	projectile.delete_requested.connect(_on_projectile_delete_requested)

func _on_projectile_delete_requested(projectile):
	projectile_container.remove_child(projectile)
	projectile.queue_free()

func _on_timer_timeout() -> void:
	fire()
