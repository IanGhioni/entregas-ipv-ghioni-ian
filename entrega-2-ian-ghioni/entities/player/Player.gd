extends Sprite2D

@onready var cannon: Sprite2D = $Cannon

var speed = 200 #Pixeles
var velocity

var projectile_container:Node

func set_projectile_container(container:Node): 
	cannon.projectile_container = container
	projectile_container = container

func _physics_process(delta):

	var direction_optimized:int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	
	var mouse_position: Vector2 = get_global_mouse_position()
	var origen:Vector2 = global_position
	var direction_vector = mouse_position - origen
		
	cannon.look_at(mouse_position)
	
	if Input.is_action_just_pressed("shoot"):
		cannon.fire()
	
	position.x += direction_optimized * speed * delta
