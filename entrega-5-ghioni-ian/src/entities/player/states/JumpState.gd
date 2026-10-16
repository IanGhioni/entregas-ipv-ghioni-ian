extends PlayerState

var jumps: int = 0

@export
var jumps_limit: int = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func enter() -> void:
	character.velocity.y -= character.jump_speed
	character._play_animation(&"jump")


# Limpia el estado. Por ej, reiniciar valores de variables o detener timers
func exit() -> void:
	jumps = 0


# Callback derivado de _input
func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") && jumps < jumps_limit:
		jumps += 1
		character.velocity.y -= character.jump_speed
		character._play_animation(&"jump")


# Callback derivado de _physics_process
func update(delta: float) -> void:
	character._handle_move_input(delta)
	if character.h_movement_direction == 0:
		character._handle_deacceleration(delta)
	character._apply_movement(delta)
	
	if character.is_on_floor():
		if character.h_movement_direction == 0:
			emit_signal("finished", "idle")
		else:
			emit_signal("finished", "walk")
	else:
			if character.velocity.y > 0:
				character._play_animation(&"fall")
			else:
				character._play_animation(&"jump")



# Callback cuando finaliza una animación en tiempo del estado actual
func _on_animation_finished(anim_name: StringName) -> void:
	return

func handle_event(event: StringName, value = null) -> void:
	match event:
		&"hit":
			character._handle_hit(value)
			if character.dead:
				finished.emit(&"die")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
