extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var shoot_position: = $ShootPosition
@export var projectile_scene:PackedScene 
@onready var camera = $Camera

var projectile_container:Node
var tilemap: TileMapLayer
var attacking:bool = false
var isDead:bool = false

func set_projectile_container_and_map(container:Node, tilemap: TileMapLayer): 
	projectile_container = container
	self.tilemap = tilemap

func _physics_process(delta: float) -> void:
	#var map_limits = tilemap.get_used_rect()
	#var map_cellsize = tilemap.tile_set.tile_size
	#camera.limit_left = map_limits.position.x * map_cellsize.x
	#camera.limit_right = map_limits.end.x * map_cellsize.x
	#camera.limit_top = map_limits.position.y * map_cellsize.y
	#camera.limit_bottom = map_limits.end.y * map_cellsize.y
	#camera.align()
	
	if is_on_floor():
		self.handleWalkAndAttack(delta)	
	else:
		if velocity.y > 0:
			animatedSprite.play("fall")
	self.handleJump(delta)
		
	move_and_slide()

func handleJump(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		if Input.is_action_just_pressed("ui_jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			animatedSprite.play("jump")


func handleWalkAndAttack(delta):
	if attacking or isDead:
		return
	
	if Input.is_action_just_pressed("attack") and is_on_floor():
		attacking = true
		animatedSprite.play("attack")
		self.attack()
		return
		
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animatedSprite.play("walk")
		animatedSprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animatedSprite.play("idle")


func _on_animated_sprite_2d_animation_finished() -> void:
	print(animatedSprite.animation == "attack")
	if animatedSprite.animation == "attack":
		attacking = false
		animatedSprite.play("idle")
	else:
		if isDead:
			self.queue_free()

func attack():
	velocity.x = 0
	var projectile_instance:Projectile = projectile_scene.instantiate()
	projectile_instance.startAnimation()
	projectile_container.add_child(projectile_instance)
	projectile_instance.set_starting_values(shoot_position.global_position, 
											(get_global_mouse_position() - global_position).normalized(), 
											self)
	projectile_instance.delete_requested.connect(_on_projectile_delete_requested)

func death():
	velocity.x = 0
	self.isDead = true
	animatedSprite.play("death")

func _on_projectile_delete_requested(projectile):
	projectile_container.remove_child(projectile)
	projectile.queue_free()
