extends Sprite2D

@export var speed:float = 150

func _process(delta: float) -> void:
	#var direction:int = 0
	#
	#if Input.is_action_pressed("move_left"):
		#direction = -1
	#elif Input.is_action_pressed("move_right"): 
		#direction = 1 
		
	var direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	
	position.x += direction * speed * delta;
