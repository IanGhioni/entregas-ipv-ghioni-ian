extends StaticBody2D

var player = null

@export var projectile_scene:PackedScene 
var projectile_container:Node
var isDead = false
func set_values(projectile_container):
	$AnimatedSprite2D.play("idle")
	$Timer.start()
	self.projectile_container = projectile_container

	
func fire():
	$WherePlayer.target_position = to_local(player.global_position)
	$WherePlayer.force_raycast_update()
	if $WherePlayer.is_colliding():
		print("entro a primer condicional")
		if $WherePlayer.get_collider() == player:
			print("el collider dice que es el player")
			$AnimatedSprite2D.play("attack")

			var projectile:Projectile = projectile_scene.instantiate()
			projectile.startAnimation()
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
	else:
		$AnimatedSprite2D.play("idle")

func death():
	$Timer.stop()
	self.isDead = true
	$AnimatedSprite2D.play("death")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	player = null


func _on_animated_sprite_2d_animation_finished() -> void:
	if isDead:
		self.queue_free()
