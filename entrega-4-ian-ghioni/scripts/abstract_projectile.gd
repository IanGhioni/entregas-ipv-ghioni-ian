extends Area2D

class_name Projectile
signal  delete_requested(projectile)
@export var speed:float

var shooter
var direction:Vector2

func _ready() -> void:
	set_physics_process(false)
	body_entered.connect(_on_collision)

func set_starting_values(starting_position:Vector2, direction, shooter):
	global_position = starting_position
	self.shooter = shooter
	self.direction = direction
	set_physics_process(true)
	rotation = direction.angle()
	$Timer.start()

func _physics_process(delta):
	position += direction*speed*delta


func _on_timer_timeout() -> void:
	emit_signal("delete_requested", self)

func startAnimation():
	$AnimatedSprite2D.play("default")


func _on_collision(body: Node2D):
	if body == shooter:
		return
	if body is CharacterBody2D:
		print("entro aca")
		body.death()
	if body is StaticBody2D:
		body.death()
	emit_signal("delete_requested", self)
