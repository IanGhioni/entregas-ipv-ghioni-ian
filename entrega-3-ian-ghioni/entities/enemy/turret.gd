extends StaticBody2D

var player 

@export var projectile_scene:PackedScene 
var projectile_container:Node

func set_values(projectile_container):
	$Timer.start()
	self.projectile_container = projectile_container

	
func fire():
	$WherePlayer.target_position = to_local(player.global_position)
	$WherePlayer.force_raycast_update()
	if $WherePlayer.is_colliding():
		if $WherePlayer.get_collider() == player:
			var projectile:Projectile = projectile_scene.instantiate()
			projectile_container.add_child(projectile)
			projectile.set_starting_values($Marker2D.global_position, 
											(player.global_position - $Marker2D.global_position).normalized(),
											self)
			projectile.delete_requested.connect(_on_projectile_delete_requested)

func _on_projectile_delete_requested(projectile):
	projectile_container.remove_child(projectile)
	projectile.queue_free()

func _on_timer_timeout() -> void:
	if player != null:
		fire()


func _on_area_2d_body_entered(body: Node2D) -> void:
	player =  body


func _on_area_2d_body_exited(body: Node2D) -> void:
	player = null
