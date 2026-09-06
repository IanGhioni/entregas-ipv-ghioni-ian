extends Area2D

class_name Projectile
signal  delete_requested(projectile)
@export var speed:float

var direction:Vector2
var shooter

func _ready() -> void:
	set_physics_process(false)
	body_entered.connect(_on_collision)

func _on_collision(body: Node2D):
	print(body.name)
	print(self.shooter)
	if body == self.shooter: 
		return
	if body is CharacterBody2D:
		body.queue_free() 
	if body is StaticBody2D:
		if body.name.contains("Turret"):
			body.queue_free()
	emit_signal("delete_requested", self)

func set_starting_values(starting_position:Vector2, direction, shooter):
	self.shooter = shooter
	global_position = starting_position
	self.direction = direction
	set_physics_process(true)
	$Timer.start()

func _physics_process(delta):
	position += direction*speed*delta


func _on_timer_timeout() -> void:
	emit_signal("delete_requested", self)
