extends Sprite2D

var speed = 400
var angular_speed = PI
var saltando = false


func _ready() -> void:
	# conectamos la señal timeout del timer por codigo (como en el tutorial)
	var timer = get_node("Timer")
	timer.timeout.connect(_on_timer_timeout)


func _process(delta: float) -> void:
	var direccionx := Input.get_axis("move_left", "move_right")
	var direcciony := Input.get_axis("move_up", "move_down")

	# rotacion en circulos
	rotation += angular_speed * delta
	var velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta

	# movimiento con las flechas
	position.x += direccionx * speed * delta
	position.y += direcciony * speed * delta

	# solo saltamos si no estamos ya en el aire
	if Input.is_action_just_pressed("jump") and not saltando:
		saltar()


func saltar() -> void:
	saltando = true
	var tween = create_tween()

	# as_relative: sube 30 y baja 30 desde donde este
	tween.tween_property(self, "position:y", -30.0, 0.15).as_relative()
	tween.tween_property(self, "position:y", 30.0, 0.15).as_relative()
	tween.finished.connect(func(): saltando = false)


# señal pressed del boton, conectada desde el editor
func _on_button_pressed() -> void:
	set_process(not is_processing())


# señal timeout del timer, conectada en _ready
func _on_timer_timeout() -> void:
	visible = not visible
