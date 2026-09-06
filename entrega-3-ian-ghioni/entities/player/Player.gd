extends CharacterBody2D

@onready var cannon: Sprite2D = $Cannon

var speed = 30
var jump_speed = -600
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var projectile_container:Node

func set_projectile_container(container:Node): 
	cannon.projectile_container = container
	projectile_container = container

func _physics_process(delta):
	velocity.y += gravity * delta
	var direction_optimized:int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	
	var mouse_position: Vector2 = get_global_mouse_position()
	var origen:Vector2 = global_position
	var direction_vector = mouse_position - origen
		
	cannon.look_at(mouse_position)
	
	if Input.is_action_just_pressed("shoot"):
		cannon.fire()
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = jump_speed
	
	velocity.x += direction_optimized * speed
	
	move_and_slide()
	
