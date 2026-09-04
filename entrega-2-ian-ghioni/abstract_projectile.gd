extends Sprite2D

class_name Projectile
signal  delete_requested(projectile)
@export var speed:float

var direction:Vector2

func _ready() -> void:
	set_physics_process(false)

func set_starting_values(starting_position:Vector2, direction):
	global_position = starting_position
	self.direction = direction
	set_physics_process(true)
	$Timer.start()

func _physics_process(delta):
	position += direction*speed*delta


func _on_timer_timeout() -> void:
	emit_signal("delete_requested", self)
